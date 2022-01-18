import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pano_rtc/pano_rtc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:count_stepper/count_stepper.dart';
import 'dart:convert';

class WhiteboardViewController extends StatefulWidget {
  RtcWhiteboard? whiteboardEngine;
  WhiteboardViewController({Key? key, required this.whiteboardEngine})
      : super(key: key);

  @override
  _WhiteboardViewControllerState createState() =>
      _WhiteboardViewControllerState();
}

class _WhiteboardViewControllerState extends State<WhiteboardViewController> {
  RtcWhiteboard? whiteboardEngine;
  late RtcWhiteboardSurfaceViewModel drawView;
  int kDefaultLineWidth = 5;
  int kDefaultFontSize = 100;

  bool isBoldStyle = false;
  bool isItalicStyle = false;
  int lineWidth = 5;
  int fontSize = 100;
  int? curPage = 0;
  int? totalPages = 1;
  double zoomScale = 100;

  bool isDrawTool = false;
  bool isStyleView = false;
  bool isPickImage = false;
  WBToolType? selectTool;
  Color selColor = Colors.black;

  File? selectFile;

  String txtDocId = '';

  @override
  void initState() {
    whiteboardEngine = widget.whiteboardEngine;
    super.initState();
    createEngineKit();
  }

  Future<ResultCode> initToolType() async {
    selectTool = WBToolType.Path;
    return whiteboardEngine!.setToolType(WBToolType.Path);
  }

  Future<ResultCode> initLineWidth() {
    lineWidth = kDefaultLineWidth;
    return whiteboardEngine!.setLineWidth(lineWidth);
  }

  Future<ResultCode> initForegroundColor() {
    return whiteboardEngine!.setForegroundColor(convertWBColor(Colors.black));
  }

  Future<ResultCode> initFontStyle() {
    return whiteboardEngine!.setFontStyle(getFontStyle());
  }

  Future<ResultCode> initFontSize() {
    fontSize = kDefaultFontSize;
    return whiteboardEngine!.setFontSize(fontSize);
  }

  Future<int?> initPageNumber() async {
    curPage = await whiteboardEngine!.getCurrentPageNumber();
    totalPages = await whiteboardEngine!.getTotalNumberOfPages();
    return totalPages;
  }

  Future<double> initZoomScale() async {
    zoomScale = (await whiteboardEngine!.getCurrentScaleFactor()) * 100.0;
    return zoomScale;
  }

  Future<ResultCode> addImageFile() async {
    return await whiteboardEngine!.addImageFile(
        'https://www.pano.video/assets/img/optimized_logo-pano.png');
  }

  createEngineKit() async {
    await initToolType();
    await initLineWidth();
    await initForegroundColor();
    await initFontStyle();
    await initFontSize();
    await initPageNumber();
    await initZoomScale();
    await addImageFile();

    whiteboardEngine!.setEventHandler(
      WhiteboardEventHandler(
          onPageNumberChanged: (curPage, totalPages) {
            this.curPage = curPage;
            this.totalPages = totalPages;
            if (mounted) setState(() {});
          },
          onImageStateChanged: (url, status) {},
          onViewScaleChanged: (scale) {
            zoomScale = scale * 100.0;
            if (mounted) setState(() {});
          },
          onSnapshotComplete: (result, fileId) {
            print('The whiteboard snapshot complete with ' + result.toString());
            print('file:' + fileId);
          },
          onVisionShareStarted: (userId) {
            print('onVisionShareStarted $userId');
            whiteboardEngine!.startFollowVision();
          },
          onVisionShareStopped: (userId) {
            print('onVisionShareStopped $userId');
            whiteboardEngine!.stopFollowVision();
          },
          onMessage: (userId, byte) {
            print('onMessage userId: $userId');
            print('onMessage byte:' + utf8.decode(byte));
          }),
    );
  }

  void close() {
    whiteboardEngine!.close();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      RtcWhiteboardSurfaceView(
        onViewCreated: (viewModel) {
          setState(() {
            drawView = viewModel;
            whiteboardEngine!.open(drawView);
            whiteboardEngine!.startShareVision();
          });
        },
      ),
      SafeArea(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Spacer(),
              Column(
                children: [
                  Visibility(
                    visible: isStyleView && selectTool == WBToolType.Text,
                    child: Row(
                      children: [
                        Text('Font : '),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300],
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              setState(() {
                                isBoldStyle = !isBoldStyle;
                                selectFontStyle();
                              });
                            },
                            child: Icon(
                              Icons.format_bold,
                              color: isBoldStyle ? Colors.blue : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300],
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              setState(() {
                                isItalicStyle = !isItalicStyle;
                                selectFontStyle();
                              });
                            },
                            child: Icon(
                              Icons.format_italic,
                              color: isItalicStyle ? Colors.blue : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 36,
                          child: CountStepper(
                            iconColor: Theme.of(context).primaryColor,
                            defaultValue: 10,
                            max: 100,
                            min: 1,
                            // iconDecrementColor: Colors.red,
                            splashRadius: 25,
                            onPressed: (int value) {
                              print('Font Size: $value');
                              fontSize = value;
                              changeFontSize();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isStyleView,
                    child: Row(
                      children: [
                        Text("Line width: "),
                        Container(
                          height: 50,
                          child: CountStepper(
                            iconColor: Theme.of(context).primaryColor,
                            defaultValue: 4,
                            max: 20,
                            min: 1,
                            splashRadius: 25,
                            onPressed: (int value) {
                              print('Line Width: $value');
                              lineWidth = value;
                              changeLineWidth();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 4,
              ),
              Visibility(
                visible: isStyleView,
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.start,
                  spacing: 1,
                  runSpacing: 1,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.red);
                        },
                        child: Container(
                          child: selColor == Colors.red
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.green);
                        },
                        child: Container(
                          child: selColor == Colors.green
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.blue);
                        },
                        child: Container(
                          child: selColor == Colors.blue
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.black);
                        },
                        child: Container(
                          child: selColor == Colors.black
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.grey);
                        },
                        child: Container(
                          child: selColor == Colors.grey
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.white);
                        },
                        child: Container(
                          child: selColor == Colors.white
                              ? Icon(Icons.done, color: Colors.black)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          selectColor(Colors.yellow);
                        },
                        child: Container(
                          child: selColor == Colors.yellow
                              ? Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Visibility(
                visible: isDrawTool,
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.start,
                  spacing: 1,
                  runSpacing: 1,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: toolButtonStyle,
                        onPressed: () {
                          setState(() {
                            setPathTool();
                          });
                        },
                        child: Icon(
                          Icons.mode_edit,
                          color: WBToolType.Path == selectTool
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: toolButtonStyle,
                        onPressed: () {
                          setState(() {
                            setLineTool();
                          });
                        },
                        child: Icon(
                          Icons.linear_scale,
                          color: WBToolType.Line == selectTool
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: toolButtonStyle,
                        onPressed: () {
                          setState(() {
                            setRectTool();
                          });
                        },
                        child: Icon(
                          Icons.crop_square,
                          color: WBToolType.Rect == selectTool
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: toolButtonStyle,
                        onPressed: () {
                          setState(() {
                            setEllipseTool();
                          });
                        },
                        child: Icon(
                          Icons.circle,
                          color: WBToolType.Ellipse == selectTool
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: toolButtonStyle,
                        onPressed: () {
                          setState(() {
                            setArrowTool();
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: WBToolType.Arrow == selectTool
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 1,
                runSpacing: 1,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        setState(() {
                          setSelectTool();
                        });
                      },
                      child: Icon(
                        Icons.select_all,
                        color: WBToolType.Select == selectTool
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        setState(() {
                          showDrawToolbar();
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        color: [
                          WBToolType.Path,
                          WBToolType.Rect,
                          WBToolType.Arrow,
                          WBToolType.Line,
                          WBToolType.Ellipse
                        ].contains(selectTool)
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        setState(() {
                          setTextTool();
                        });
                      },
                      child: Icon(
                        Icons.text_fields_rounded,
                        color: WBToolType.Text == selectTool
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        setState(() {
                          setEraserTool();
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: WBToolType.Eraser == selectTool
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        setState(() {
                          showStyleView();
                        });
                      },
                      child: Icon(
                        Icons.style,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: toolButtonStyle,
                      onPressed: () {
                        snapshotWhiteboard();
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: pageButtonStyle,
              onPressed: () {
                prevPage();
              },
              child: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(" $curPage of  $totalPages"),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: pageButtonStyle,
              onPressed: () {
                nextPage();
              },
              child: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: pageButtonStyle,
              onPressed: () {
                addPage();
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: pageButtonStyle,
              onPressed: () {
                removePage();
              },
              child: Icon(
                Icons.remove_circle,
                color: Colors.black,
              ),
            ),
          ),
          Text(" ${zoomScale.toInt()}%"),
          SizedBox(
            width: 70,
          ),
          Spacer(),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: toolButtonStyle,
              onPressed: () {
                setState(() {
                  undoOperation();
                });
              },
              child: Icon(
                Icons.undo,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: toolButtonStyle,
              onPressed: () {
                setState(() {
                  redoOperation();
                });
              },
              child: Icon(
                Icons.redo,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 140,
          ),
        ],
      )
    ]
        // ),
        );
  }

  final ButtonStyle toolButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.grey[300],
    padding: EdgeInsets.zero,
    shape: CircleBorder(),
  );

  final ButtonStyle pageButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.grey[300],
    padding: EdgeInsets.zero,
    // shape: CircleBorder(),
  );

  WBFontStyle getFontStyle() {
    var style = WBFontStyle.Normal;
    if (isBoldStyle && isItalicStyle) {
      style = WBFontStyle.BoldItalic;
    } else if (isBoldStyle) {
      style = WBFontStyle.Bold;
    } else if (isItalicStyle) {
      style = WBFontStyle.Italic;
    }
    return style;
  }

  WBColor convertWBColor(Color color) {
    return WBColor(
        red: color.red / 255.0,
        green: color.green / 255.0,
        blue: color.blue / 255.0,
        alpha: color.alpha / 255.0);
  }

  void hideAllSubToolViews() {
    isDrawTool = false;
    isStyleView = false;
  }

  void setSelectTool() {
    hideAllSubToolViews();
    selectTool = WBToolType.Select;
    whiteboardEngine!.setToolType(WBToolType.Select);
  }

  void showDrawToolbar() {
    hideAllSubToolViews();
    isDrawTool = true;
  }

  void setPathTool() {
    selectTool = WBToolType.Path;
    whiteboardEngine!.setToolType(WBToolType.Path);
  }

  void setLineTool() {
    selectTool = WBToolType.Line;
    whiteboardEngine!.setToolType(WBToolType.Line);
  }

  void setRectTool() {
    selectTool = WBToolType.Rect;
    whiteboardEngine!.setToolType(WBToolType.Rect);
  }

  void setEllipseTool() {
    selectTool = WBToolType.Ellipse;
    whiteboardEngine!.setToolType(WBToolType.Ellipse);
  }

  void setArrowTool() {
    selectTool = WBToolType.Arrow;
    whiteboardEngine!.setToolType(WBToolType.Arrow);
  }

  void setTextTool() {
    hideAllSubToolViews();
    selectTool = WBToolType.Text;
    whiteboardEngine!.setToolType(WBToolType.Text);
  }

  void setEraserTool() {
    hideAllSubToolViews();
    selectTool = WBToolType.Eraser;
    whiteboardEngine!.setToolType(WBToolType.Eraser);
  }

  void showStyleView() {
    isDrawTool = false;
    isStyleView = true;
  }

  void setImage(String url,
      {WBImageScalingMode scalMode = WBImageScalingMode.Fit}) {
    hideAllSubToolViews();
    whiteboardEngine!.setBackgroundImageScalingMode(scalMode);
    whiteboardEngine!.setBackgroundImage(url);
  }

  void snapshotWhiteboard() async {
    var path = await getApplicationDocumentsDirectory();
    print(path.path);
    var code = await whiteboardEngine!.snapshot(WBSnapshotMode.All, path.path);

    print(code.toString());
  }

  void undoOperation() {
    hideAllSubToolViews();
    whiteboardEngine!.undo();
  }

  void redoOperation() {
    hideAllSubToolViews();
    whiteboardEngine!.redo();
  }

  void selectColor(Color color) {
    setState(() {
      selColor = color;
    });

    var fgColor = convertWBColor(color);
    whiteboardEngine!.setForegroundColor(fgColor);
  }

  void changeLineWidth() {
    whiteboardEngine!.setLineWidth(lineWidth);
  }

  void selectFontStyle() {
    whiteboardEngine!.setFontStyle(getFontStyle());
  }

  void changeFontSize() {
    whiteboardEngine!.setFontSize(fontSize);
  }

  void prevPage() {
    whiteboardEngine!.prevPage();
  }

  void nextPage() {
    whiteboardEngine!.nextPage();
  }

  void addPage() {
    whiteboardEngine!.addPage(true);
  }

  void broadcastMessage(String str) {
    List<int> bytes = utf8.encode(str);
    whiteboardEngine!.broadcastMessage(bytes as Uint8List);
  }

  void removePage() {
    whiteboardEngine!.removePage(curPage!);
  }
}
