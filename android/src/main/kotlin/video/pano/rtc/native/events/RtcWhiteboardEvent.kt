package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.RtcWhiteboard

class RtcWhiteboardEvent(
        private var whiteboardId: String,
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcWhiteboard.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("whiteboardId" to whiteboardId, "data" to data.toList()))
    }

    override fun onStatusSynced() {
        callback("onStatusSynced")
    }

    override fun onPageNumberChanged(curPage: Int, totalPages: Int) {
        callback("onPageNumberChanged", curPage, totalPages)
    }

    override fun onImageStateChanged(url: String?, state: Constants.WBImageState?) {
        callback("onImageStateChanged", url, state?.value)
    }

    override fun onViewScaleChanged(scale: Float) {
        callback("onViewScaleChanged", scale)
    }

    override fun onRoleTypeChanged(newRole: Constants.WBRoleType?) {
        callback("onRoleTypeChanged", newRole?.value)
    }

    override fun onContentUpdated() {
        callback("onContentUpdated")
    }

    override fun onSnapshotComplete(result: Constants.QResult?, filename: String?) {
        callback("onSnapshotComplete", result?.value, filename)
    }

    override fun onMessage(userId: Long, bytes: ByteArray?) {
        callback("onMessage", userId.toString(), bytes)
    }

    override fun onAddBackgroundImages(result: Constants.QResult?, fileId: String?) {
        callback("onAddBackgroundImages", result?.value, fileId)
    }

    override fun onAddH5File(result: Constants.QResult?, fileId: String?) {
        callback("onAddH5File", result?.value, fileId)
    }

    override fun onDocTranscodeStatus(result: Constants.QResult?, fileId: String?, progress: Int, totalPage: Int) {
        callback("onDocTranscodeStatus", result?.value, fileId, progress, totalPage)
    }

    override fun onCreateDoc(result: Constants.QResult?, fileId: String?) {
        callback("onCreateDoc", result?.value, fileId)
    }

    override fun onDeleteDoc(result: Constants.QResult?, fileId: String?) {
        callback("onDeleteDoc", result?.value, fileId)
    }

    override fun onSwitchDoc(result: Constants.QResult?, fileId: String?) {
        callback("onSwitchDoc", result?.value, fileId)
    }

    override fun onSaveDoc(result: Constants.QResult?, fileId: String?, outputDir: String?) {
        callback("onSaveDoc", result?.value, fileId, outputDir)
    }

    override fun onDocThumbnailReady(fileId: String?, urls: List<String> ) {
        callback("onDocThumbnailReady", fileId, urls)
    }

    override fun onVisionShareStarted(userId: Long) {
        callback("onVisionShareStarted", userId.toString())
    }

    override fun onVisionShareStopped(userId: Long) {
        callback("onVisionShareStopped", userId.toString())
    }

    override fun onUserJoined(userId: Long, userName: String?) {
        callback("onUserJoined", userId.toString())
    }

    override fun onUserLeft(userId: Long) {
        callback("onUserLeft", userId.toString())
    }
}