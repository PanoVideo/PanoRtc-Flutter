import 'UserManager.dart';

import 'ChannelViewController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'ChannelInfo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: MyApp(),
    builder: EasyLoading.init(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Color(0xff3BDCE4)
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Color(0xff3BDCE4)
    ..textColor = Colors.transparent
    ..userInteractions = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController txtChannelID = TextEditingController();
  final TextEditingController txtUsername = TextEditingController();

  @override
  void initState() {
    super.initState();

    txtChannelID.addListener(() {
      ChannelInfo.setChannelId(txtChannelID.text);
    });

    txtUsername.addListener(() {
      ChannelInfo.setUserName(txtChannelID.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    txtChannelID.removeListener(() {});
    txtUsername.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                'Pano Room',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                maxLines: 1,
                controller: txtChannelID,
                autocorrect: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE7E7EF)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE7E7EF)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Channel ID'),
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff000000),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                maxLines: 1,
                controller: txtUsername,
                autocorrect: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE7E7EF)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE7E7EF)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'User name'),
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff000000),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  if (txtChannelID.text == '') {
                    return;
                  }
                  if (txtUsername.text == '') {
                    return;
                  }
                  UserManager.shared().removeAllUser();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ChannelViewController()));
                },
                child: Text('Join'),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
