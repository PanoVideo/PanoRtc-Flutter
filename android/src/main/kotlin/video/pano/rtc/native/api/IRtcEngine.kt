package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcEngine {

    fun create(params: Map<String, *>, callback: Callback)

    fun destroy(callback: Callback)
    
    fun setParameters(params: Map<String, *>, callback: Callback)

    fun joinChannel(params: Map<String, *>, callback: Callback)

    fun leaveChannel(callback: Callback)

    fun startAudio(callback: Callback)

    fun stopAudio(callback: Callback)

    fun startVideo(params: Map<String, *>, callback: Callback)

    fun stopVideo(callback: Callback)

    fun switchCamera(callback: Callback)
    
    fun isFrontCamera(callback: Callback)
    
    fun getCameraDeviceId(params: Map<String, *>, callback: Callback)

    fun startPreview(params: Map<String, *>, callback: Callback)

    fun stopPreview(callback: Callback)

    fun subscribeAudio(params: Map<String, *>, callback: Callback)

    fun unsubscribeAudio(params: Map<String, *>, callback: Callback)

    fun subscribeVideo(params: Map<String, *>, callback: Callback)

    fun unsubscribeVideo(params: Map<String, *>, callback: Callback)

    fun muteAudio(callback: Callback)

    fun unmuteAudio(callback: Callback)

    fun muteVideo(callback: Callback)

    fun unmuteVideo(callback: Callback)

    fun startScreen(callback: Callback)

    fun stopScreen(callback: Callback)

    fun subscribeScreen(params: Map<String, *>, callback: Callback)

    fun unsubscribeScreen(params: Map<String, *>, callback: Callback)

    fun setLoudspeakerStatus(params: Map<String, *>, callback: Callback)

    fun isEnabledLoudspeaker(callback: Callback)

    fun setMicrophoneMuteStatus(params: Map<String, *>, callback: Callback)

    fun setAudioDeviceVolume(params: Map<String, *>, callback: Callback)

    fun getAudioDeviceVolume(params: Map<String, *>, callback: Callback)

    fun getRecordingLevel(callback: Callback)

    fun getPlayoutLevel(callback: Callback)

    fun whiteboardEngine(callback: Callback)

    fun switchWhiteboardEngine(params: Map<String, *>, callback: Callback)

    fun annotationManager(callback: Callback)

    fun networkManager(callback: Callback)

    fun videoStreamManager(callback: Callback)

    fun messageService(callback: Callback)

    fun setOption(params: Map<String, *>, callback: Callback)

    fun snapshotVideo(params: Map<String, *>, callback: Callback)

    fun startAudioDumpWithFilePath(params: Map<String, *>, callback: Callback)

    fun stopAudioDump(callback: Callback)

    fun sendFeedback(params: Map<String, *>, callback: Callback)

    fun getSdkVersion(callback: Callback)
}