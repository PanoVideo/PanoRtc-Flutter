package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcVideoStreamManager {

    fun createVideoStream(params: Map<String, *>, callback: Callback)

    fun destroyVideoStream(params: Map<String, *>, callback: Callback)

    fun setCaptureDevice(params: Map<String, *>, callback: Callback)

    fun getCaptureDevice(params: Map<String, *>, callback: Callback)

    fun startVideo(params: Map<String, *>, callback: Callback)

    fun stopVideo(params: Map<String, *>, callback: Callback)

    fun muteVideo(params: Map<String, *>, callback: Callback)

    fun unmuteVideo(params: Map<String, *>, callback: Callback)

    fun subscribeVideo(params: Map<String, *>, callback: Callback)

    fun unsubscribeVideo(params: Map<String, *>, callback: Callback)

    fun snapshotVideo(params: Map<String, *>, callback: Callback)
}