package video.pano.rtc.native

import com.pano.rtc.api.*
import video.pano.rtc.native.api.IRtcWhiteboard
import video.pano.rtc.native.events.RtcWhiteboardEvent
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBClearType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBDocConvertType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBFillType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBFontStyle
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBImageScalingMode
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBRoleType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBSnapshotMode
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBToolType

class RtcWhiteboardEngine(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcWhiteboard {

    private var whiteboard: RtcWhiteboard? = null

    fun setInnerWhiteboard(whiteboardId: String, whiteboard: RtcWhiteboard?) {
        this.whiteboard = whiteboard
        whiteboard?.setCallback(RtcWhiteboardEvent(whiteboardId) { methodName, data ->
            emit(methodName, data)
        })
    }

    override fun setRoleType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(whiteboard?.setRoleType(getWBRoleType(type)))
    }

    override fun open(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcWbView
        callback.success(whiteboard?.open(view))
    }

    override fun close(callback: Callback) {
        callback.success(whiteboard?.close())
    }

    override fun leave(callback: Callback) {
        callback.success(whiteboard?.leave())
    }

    override fun stop(callback: Callback) {
        callback.success(whiteboard?.stop())
    }

    override fun getCurrentWhiteboardId(callback: Callback) {
        callback.success(whiteboard?.currentWhiteboardId)
    }

    override fun getToolType(callback: Callback) {
        callback.success(whiteboard?.toolType?.value)
    }

    override fun getCurrentPageNumber(callback: Callback) {
        callback.success(whiteboard?.currentPageNumber)
    }

    override fun getTotalNumberOfPages(callback: Callback) {
        callback.success(whiteboard?.totalNumberOfPages)
    }

    override fun getCurrentScaleFactor(callback: Callback) {
        callback.success(whiteboard?.currentScaleFactor)
    }

    override fun setCurrentScaleFactor(params: Map<String, *>, callback: Callback) {
        val scale = (params["scale"] as Number).toFloat()
        callback.success(whiteboard?.setCurrentScaleFactor(scale))
    }

    override fun setBackgroundImage(params: Map<String, *>, callback: Callback) {
        val imgUrl = params["imageUrl"] as String
        callback.success(whiteboard?.setBackgroundImage(imgUrl))
    }

    override fun setBackgroundImageWithPage(params: Map<String, *>, callback: Callback) {
        val imgUrl = params["imageUrl"] as String
        val pageNo = (params["pageNo"] as Number).toInt()
        callback.success(whiteboard?.setBackgroundImage(imgUrl, pageNo))
    }

    override fun setBackgroundImageScalingMode(params: Map<String, *>, callback: Callback) {
        val mode = (params["mode"] as Number).toInt()
        callback.success(whiteboard?.setBackgroundImageScalingMode(getWBImageScalingMode(mode)))
    }

    override fun setToolType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(whiteboard?.setToolType(getWBToolType(type)))
    }

    override fun setLineWidth(params: Map<String, *>, callback: Callback) {
        val width = (params["width"] as Number).toInt()
        callback.success(whiteboard?.setLineWidth(width))
    }

    override fun setFillType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(whiteboard?.setFillType(getWBFillType(type)))
    }

    override fun setFillColor(params: Map<String, *>, callback: Callback) {
        val color = params["color"] as Map<*, *>
        val red = (color["red"] as Number).toFloat()
        val green = (color["green"] as Number).toFloat()
        val blue = (color["blue"] as Number).toFloat()
        val alpha = (color["alpha"] as Number).toFloat()
        callback.success(whiteboard?.setFillColor(red, green, blue, alpha))
    }

    override fun setForegroundColor(params: Map<String, *>, callback: Callback) {
        val color = params["color"] as Map<*, *>
        val red = (color["red"] as Number).toFloat()
        val green = (color["green"] as Number).toFloat()
        val blue = (color["blue"] as Number).toFloat()
        val alpha = (color["alpha"] as Number).toFloat()
        callback.success(whiteboard?.setForegroundColor(red, green, blue, alpha))
    }

    override fun setBackgroundColor(params: Map<String, *>, callback: Callback) {
        val color = params["color"] as Map<*, *>
        val red = (color["red"] as Number).toFloat()
        val green = (color["green"] as Number).toFloat()
        val blue = (color["blue"] as Number).toFloat()
        val alpha = (color["alpha"] as Number).toFloat()
        callback.success(whiteboard?.setBackgroundColor(red, green, blue, alpha))
    }

    override fun setFontStyle(params: Map<String, *>, callback: Callback) {
        val style = (params["style"] as Number).toInt()
        callback.success(whiteboard?.setFontStyle(getWBFontStyle(style)))
    }

    override fun setFontSize(params: Map<String, *>, callback: Callback) {
        val size = (params["size"] as Number).toInt()
        callback.success(whiteboard?.setFontSize(size))
    }

    override fun addStamp(params: Map<String, *>, callback: Callback) {
        val stamp = params["stamp"] as Map<*, *>
        callback.success(whiteboard?.addStamp(WBStamp().apply {
            this.stampId = stamp["stampId"] as String
            this.path = stamp["path"] as String
            this.resizable = stamp["resizable"] as Boolean
        }))
    }

    override fun setStamp(params: Map<String, *>, callback: Callback) {
        val stampId = params["stampId"] as String
        callback.success(whiteboard?.setStamp(stampId))
    }

    override fun undo(callback: Callback) {
        callback.success(whiteboard?.undo())
    }

    override fun redo(callback: Callback) {
        callback.success(whiteboard?.redo())
    }

    override fun addPage(params: Map<String, *>, callback: Callback) {
        val autoSwitch = params["autoSwitch"] as Boolean
        callback.success(whiteboard?.addPage(autoSwitch))
    }

    override fun insertPage(params: Map<String, *>, callback: Callback) {
        val pageNo = (params["pageNo"] as Number).toInt()
        val autoSwitch = params["autoSwitch"] as Boolean
        callback.success(whiteboard?.insertPage(pageNo, autoSwitch))
    }

    override fun removePage(params: Map<String, *>, callback: Callback) {
        val pageNo = (params["pageNo"] as Number).toInt()
        val switchNext = params["switchNext"] as Boolean
        callback.success(whiteboard?.removePage(pageNo, switchNext))
    }

    override fun gotoPage(params: Map<String, *>, callback: Callback) {
        val pageNo = (params["pageNo"] as Number).toInt()
        callback.success(whiteboard?.gotoPage(pageNo))
    }

    override fun nextPage(callback: Callback) {
        callback.success(whiteboard?.nextPage())
    }

    override fun prevPage(callback: Callback) {
        callback.success(whiteboard?.prevPage())
    }

    override fun nextStep(callback: Callback) {
        callback.success(whiteboard?.nextStep())
    }

    override fun prevStep(callback: Callback) {
        callback.success(whiteboard?.prevStep())
    }

    override fun addImageFile(params: Map<String, *>, callback: Callback) {
        val imageUrl = params["imageUrl"] as String
        callback.success(whiteboard?.addImageFile(imageUrl))
    }

    override fun addAudioFile(params: Map<String, *>, callback: Callback) {
        val mediaUrl = params["mediaUrl"] as String
        callback.success(whiteboard?.addAudioFile(mediaUrl))
    }

    override fun addVideoFile(params: Map<String, *>, callback: Callback) {
        val mediaUrl = params["mediaUrl"] as String
        callback.success(whiteboard?.addVideoFile(mediaUrl))
    }

    @Suppress("UNCHECKED_CAST")
    override fun addBackgroundImages(params: Map<String, *>, callback: Callback) {
        val urls = params["urls"] as List<String>
        callback.success(whiteboard?.addBackgroundImages(urls))
    }

    override fun addH5File(params: Map<String, *>, callback: Callback) {
        val url = params["url"] as String
        val downloadUrl = when {
            params.containsKey("downloadUrl") -> {
                params["downloadUrl"] as String
            }
            else -> {
                null
            }
        }
        callback.success(whiteboard?.addH5File(url, downloadUrl))
    }

    @Suppress("UNCHECKED_CAST")
    override fun addDoc(params: Map<String, *>, callback: Callback) {
        val contents = params["contents"] as Map<*, *>
        callback.success(whiteboard?.addDoc(WBDocContents().apply {
            this.name = contents["name"] as String
            this.urls = contents["urls"] as List<String>
        }))
    }

    @Suppress("UNCHECKED_CAST")
    override fun createDocWithImages(params: Map<String, *>, callback: Callback) {
        val urls = params["urls"] as List<String>
        callback.success(whiteboard?.createDoc(urls))
    }

    override fun createDocWithFilePath(params: Map<String, *>, callback: Callback) {
        val filePath = params["filePath"] as String
        if (params.containsKey("config")) {
            val config = params["config"] as Map<*, *>
            callback.success(whiteboard?.createDoc(filePath, WBDocConvertConfig().apply {
                this.type = getWBDocConvertType((config["type"] as Number).toInt())
                this.needThumb = config["needThumb"] as Boolean
            }))
        } else {
            callback.success(whiteboard?.createDoc(filePath))
        }
    }

    override fun deleteDoc(params: Map<String, *>, callback: Callback) {
        val fileId = params["fileId"] as String
        callback.success(whiteboard?.deleteDoc(fileId))
    }

    override fun switchDoc(params: Map<String, *>, callback: Callback) {
        val fileId = params["fileId"] as String
        callback.success(whiteboard?.switchDoc(fileId))
    }

    override fun saveDocToImages(params: Map<String, *>, callback: Callback) {
        val fileId = params["fileId"] as String
        val outputDir = params["outputDir"] as String
        callback.success(whiteboard?.saveDocToImages(fileId, outputDir))
    }

    override fun enumerateFiles(callback: Callback) {
        callback.success(whiteboard?.enumerateFiles())
    }

    override fun getCurrentFileId(callback: Callback) {
        callback.success(whiteboard?.currentFileId)
    }

    override fun getFileInfo(params: Map<String, *>, callback: Callback) {
        val fileId = params["fileId"] as String
        val info = whiteboard?.getFileInfo(fileId)
        callback.success(mapOf(
                "type" to info?.type,
                "fileId" to info?.fileId,
                "name" to info?.name,
                "creator" to info?.creator.toString()))
    }

    override fun clearContents(params: Map<String, *>, callback: Callback) {
        val curPage = params["curPage"] as Boolean
        val type = (params["type"] as Number).toInt()
        callback.success(whiteboard?.clearContents(curPage, getWBClearType(type)))
    }

    override fun clearUserContents(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val curPage = params["curPage"] as Boolean
        val type = (params["type"] as Number).toInt()
        callback.success(whiteboard?.clearUserContents(userId, curPage, getWBClearType(type)))
    }

    override fun snapshot(params: Map<String, *>, callback: Callback) {
        val mode = (params["mode"] as Number).toInt()
        val outputDir = params["outputDir"] as String
        callback.success(whiteboard?.snapshot(getWBSnapshotMode(mode), outputDir))
    }

    override fun startShareVision(callback: Callback) {
        callback.success(whiteboard?.startShareVision())
    }

    override fun stopShareVision(callback: Callback) {
        callback.success(whiteboard?.stopShareVision())
    }

    override fun startFollowVision(callback: Callback) {
        callback.success(whiteboard?.startFollowVision())
    }

    override fun stopFollowVision(callback: Callback) {
        callback.success(whiteboard?.stopFollowVision())
    }

    override fun syncVision(callback: Callback) {
        callback.success(whiteboard?.syncVision())
    }

    override fun sendMessage(params: Map<String, *>, callback: Callback) {
        val message = params["message"] as ByteArray
        val userId = (params["userId"] as String).toLong()
        callback.success(whiteboard?.sendMessage(userId, message))
    }

    override fun broadcastMessage(params: Map<String, *>, callback: Callback) {
        val message = params["message"] as ByteArray
        callback.success(whiteboard?.broadcastMessage(message))
    }

    override fun setOption(params: Map<String, *>, callback: Callback) {

        when ((params["type"] as Number).toInt()) {
            1 -> { //FileCachePath
                val path = params["option"] as String
                callback.success(whiteboard?.setFileCachePath(path))
            }
            2 -> { //EnableUIResponse
                val enable = params["option"] as Boolean
                callback.success(whiteboard?.enableUIResponse(enable))
            }
            3 -> { //EnableShowDraws
                val enable = params["option"] as Boolean
                callback.success(whiteboard?.enableShowDraws(enable))
            }
            4 -> { //ScaleMove
                val enable = params["option"] as Boolean
                callback.success(whiteboard?.enableScaleMove(enable))
            }
            5 -> { //AutoSelected
                val enable = params["option"] as Boolean
                callback.success(whiteboard?.enableAutoSelected(enable))
            }
        }
    }
}