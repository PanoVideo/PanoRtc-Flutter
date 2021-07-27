package video.pano.rtc.native

import android.content.Context
import com.pano.rtc.api.*
import com.pano.rtc.api.model.RtcAudioProfile
import video.pano.rtc.native.api.IRtcAudioMixingManager
import video.pano.rtc.native.api.IRtcEngine
import video.pano.rtc.native.api.IRtcManagerCreator
import video.pano.rtc.native.events.RtcEngineEvent
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioChannel
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioDeviceType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioEqualizationMode
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioProfileQuality
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioReverbMode
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAudioSampleRate
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getFeedbackType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getImageFileFormat
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getOptionType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getVideoFrameRateType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getVideoProfileType

class RtcEngineManager(
        private val managerCreator: IRtcManagerCreator,
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcEngine, IRtcAudioMixingManager {
    private val whiteboardMap = HashMap<String, RtcWhiteboardEngine?>()
    private var currentWhiteboardId: String = "default"
    private var engine: RtcEngine? = null
    var annotationMgr: RtcAnnotationMgr? = null
    var networkMgr: RtcNetworkMgr? = null
    var videoStreamMgr: RtcVideoStreamMgr? = null
    var rtcMessageSrv: RtcMessageSrv? = null
    var frontCamera: Boolean = true

    fun getRtcWhiteboardEngine(whiteboardId: String): RtcWhiteboardEngine? {
        return whiteboardMap[whiteboardId]
    }

    override fun create(params: Map<String, *>, callback: Callback) {
        val rtcEngineEvent = RtcEngineEvent { methodName, data ->
            emit(methodName, data)
        }
        val configMap = params["config"] as Map<*, *>
        val config = RtcEngineConfig().apply {
            this.context = params["context"] as Context
            this.appId = configMap["appId"] as String
            this.server = configMap["rtcServer"] as String
            this.videoCodecHwAcceleration = configMap["videoCodecHwAcceleration"] as Boolean
            this.audioScenario = (configMap["audioScenario"] as Number).toInt()
            this.callback = rtcEngineEvent
        }
        engine = RtcEngine.create(config)
        engine?.setMediaStatsObserver(rtcEngineEvent)
        callback.success(when {
            engine != null -> Constants.QResult.OK
            else -> Constants.QResult.NotInitialized
        })
    }

    override fun destroy(callback: Callback) {
        RtcEngine.destroy()
        engine = null
        whiteboardMap.clear()
        annotationMgr?.destroy()
        annotationMgr = null
        networkMgr = null
        videoStreamMgr = null
        rtcMessageSrv = null
        frontCamera = true
        callback.success(Constants.QResult.OK)
    }

    override fun setParameters(params: Map<String, *>, callback: Callback) {
        callback.success(engine?.setParameters((params["param"]) as String))
    }

    override fun joinChannel(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val channelId = params["channelId"] as String
        val token = params["token"] as String
        val config = params["config"] as Map<*, *>
        val serviceFlagsList = config["serviceFlags"] as List<*>
        var serviceFlags = 0
        serviceFlagsList.forEach {
            serviceFlags = serviceFlags or (it as Number).toInt()
        }
        val rtcChannelConfig = RtcChannelConfig().apply {
            this.mode_1v1 = (config["mode"] as Number).toInt() == 0
            this.serviceFlags = serviceFlags
            this.subscribeAudioAll = config["subscribeAudioAll"] as Boolean
            this.userName = config["userName"] as String
        }
        callback.success(engine?.joinChannel(token, channelId, userId, rtcChannelConfig))
    }

    override fun leaveChannel(callback: Callback) {
        callback.success(engine?.leaveChannel())
    }

    override fun startAudio(callback: Callback) {
        callback.success(engine?.startAudio())
    }

    override fun stopAudio(callback: Callback) {
        callback.success(engine?.stopAudio())
    }

    override fun startVideo(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val configMap = params["config"] as Map<*, *>
        val config = RtcVideoConfig().apply {
            this.profileType = getVideoProfileType((configMap["profileType"] as Number).toInt())
            this.sourceMirror = configMap["sourceMirror"] as Boolean
        }
        view.mirror = configMap["mirror"] as Boolean
        engine?.setLocalVideoRender(view)
        callback.success(engine?.startVideo(frontCamera, config))
    }

    override fun stopVideo(callback: Callback) {
        callback.success(engine?.stopVideo())
    }

    override fun switchCamera(callback: Callback) {
        frontCamera = !frontCamera
        callback.success(engine?.switchCamera())
    }

    override fun isFrontCamera(callback: Callback) {
        callback.success(frontCamera)
    }

    override fun getCameraDeviceId(params: Map<String, *>, callback: Callback) {
        val frontCamera = params["frontCamera"] as Boolean
        val keyWord : String = if (frontCamera) "front" else "back"
        val deviceList = engine?.videoDeviceManager?.captureDeviceList
        if (deviceList.isNullOrEmpty()) {
            callback.success(null)
        } else {
            var deviceId = ""
            for (i in deviceList.indices) {
                if (deviceList[i].deviceId.contains(keyWord)) {
                    deviceId = deviceList[i].deviceId
                    break
                }
            }
            callback.success(deviceId)
        }
    }

    override fun startPreview(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val configMap = params["config"] as Map<*, *>
        val profileType = getVideoProfileType((configMap["profileType"] as Number).toInt())
        view.mirror = configMap["mirror"] as Boolean
        engine?.setLocalVideoRender(view)
        callback.success(engine?.startPreview(profileType, frontCamera))
    }

    override fun stopPreview(callback: Callback) {
        callback.success(engine?.stopPreview())
    }

    override fun subscribeAudio(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        callback.success(engine?.subscribeAudio(userId))
    }

    override fun unsubscribeAudio(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        callback.success(engine?.unsubscribeAudio(userId))
    }

    override fun subscribeVideo(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val userId = (params["userId"] as String).toLong()
        val configMap = params["config"] as Map<*, *>
        val profileType = getVideoProfileType((configMap["profileType"] as Number).toInt())
        view.mirror = configMap["mirror"] as Boolean
        engine?.setRemoteVideoRender(userId, view)
        callback.success(engine?.subscribeVideo(userId, profileType))
    }

    override fun unsubscribeVideo(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        callback.success(engine?.unsubscribeVideo(userId))
    }

    override fun muteAudio(callback: Callback) {
        callback.success(engine?.muteAudio())
    }

    override fun unmuteAudio(callback: Callback) {
        callback.success(engine?.unmuteAudio())
    }

    override fun muteVideo(callback: Callback) {
        callback.success(engine?.muteVideo())
    }

    override fun unmuteVideo(callback: Callback) {
        callback.success(engine?.unmuteVideo())
    }

    override fun startScreen(callback: Callback) {
        callback.success(engine?.startScreen())
    }

    override fun stopScreen(callback: Callback) {
        callback.success(engine?.stopScreen())
    }

    override fun subscribeScreen(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val userId = (params["userId"] as String).toLong()
        engine?.setRemoteScreenRender(userId, view)
        callback.success(engine?.subscribeScreen(userId))
    }

    override fun unsubscribeScreen(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        callback.success(engine?.unsubscribeScreen(userId))
    }

    override fun setLoudspeakerStatus(params: Map<String, *>, callback: Callback) {
        val enable = params["enable"] as Boolean
        callback.success(engine?.setLoudspeakerStatus(enable))
    }

    override fun isEnabledLoudspeaker(callback: Callback) {
        callback.success(engine?.isLoudspeakerOn)
    }

    override fun setMicrophoneMuteStatus(params: Map<String, *>, callback: Callback) {
        val enable = params["enable"] as Boolean
        callback.success(engine?.setMicrophoneMuteStatus(enable))
    }

    override fun setAudioDeviceVolume(params: Map<String, *>, callback: Callback) {
        val volume = (params["volume"] as Number).toInt()
        val type = (params["type"] as Number).toInt()
        when (getAudioDeviceType(type)) {
            Constants.AudioDeviceType.Record -> {
                callback.success(engine?.setRecordDeviceVolume(volume))
            }
            Constants.AudioDeviceType.Playout -> {
                callback.success(engine?.setPlayoutDeviceVolume(volume))
            }
            else -> {
                callback.failure(Constants.QResult.InvalidArgs.name, "setAudioDeviceVolume Unsupported AudioDeviceType($type)")
            }
        }
    }

    override fun getAudioDeviceVolume(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        when (getAudioDeviceType(type)) {
            Constants.AudioDeviceType.Record -> {
                callback.success(engine?.recordDeviceVolume)
            }
            Constants.AudioDeviceType.Playout -> {
                callback.success(engine?.playoutDeviceVolume)
            }
            else -> {
                callback.failure(Constants.QResult.InvalidArgs.name, "getAudioDeviceVolume Unsupported AudioDeviceType($type)")
            }
        }
    }

    override fun getRecordingLevel(callback: Callback) {
        callback.success(engine?.recordingLevel)
    }

    override fun getPlayoutLevel(callback: Callback) {
        callback.success(engine?.playoutLevel)
    }

    override fun whiteboardEngine(callback: Callback) {
        val whiteboard = engine?.whiteboard
        var whiteboardEngine = whiteboardMap[currentWhiteboardId]
        if (whiteboardEngine == null) {
            whiteboardEngine = managerCreator.createWhiteboardEngine(currentWhiteboardId, whiteboard)
            whiteboardMap[currentWhiteboardId] = whiteboardEngine
        }
        callback.success(currentWhiteboardId)
    }

    override fun switchWhiteboardEngine(params: Map<String, *>, callback: Callback) {
        val whiteboardId = params["whiteboardId"] as String
        val result = engine?.switchWhiteboard(whiteboardId)
        currentWhiteboardId = whiteboardId
        callback.success(result)
    }

    override fun annotationManager(callback: Callback) {
        if (annotationMgr == null) {
            annotationMgr = managerCreator.createAnnotationMgr(engine?.annotationMgr)
        }
        callback.success(when (annotationMgr) {
            null -> Constants.QResult.NotInitialized
            else -> Constants.QResult.OK
        })
    }

    override fun networkManager(callback: Callback) {
        if (networkMgr == null) {
            networkMgr = managerCreator.createNetworkMgr(engine?.networkManager)
        }
        callback.success(when (networkMgr) {
            null -> Constants.QResult.NotInitialized
            else -> Constants.QResult.OK
        })
    }

    override fun videoStreamManager(callback: Callback) {
        if (videoStreamMgr == null) {
            videoStreamMgr = managerCreator.createVideoStreamMgr(engine?.videoStreamManager)
        }
        callback.success(when (videoStreamMgr) {
            null -> Constants.QResult.NotInitialized
            else -> Constants.QResult.OK
        })
    }

    override fun messageService(callback: Callback) {
        if (rtcMessageSrv == null) {
            rtcMessageSrv = managerCreator.createRtcMessageSrv(engine?.messageService)
        }
        callback.success(when (rtcMessageSrv) {
            null -> Constants.QResult.NotInitialized
            else -> Constants.QResult.OK
        })
    }

    override fun setOption(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        if (type == 0) { //FaceBeautify

            val optionMap = params["option"] as Map<*, *>
            val enable = optionMap["enable"] as Boolean
            val intensity = (optionMap["intensity"] as Number).toFloat()
            engine?.setFaceBeautify(enable)
            engine?.setFaceBeautifyIntensity(intensity)
            callback.success(Constants.QResult.OK)

        } else if (type == 3) { //AudioEqualizationMode

            val option = (params["option"] as Number).toInt()
            callback.success(engine?.setAudioEqualization(getAudioEqualizationMode(option)))

        } else if (type == 4) { //AudioReverbMode

            val option = (params["option"] as Number).toInt()
            callback.success(engine?.setAudioReverb(getAudioReverbMode(option)))

        } else if (type == 5) { //VideoFrameRate

            val option = (params["option"] as Number).toInt()
            callback.success(engine?.setVideoFrameRate(getVideoFrameRateType(option)))

        } else {
            val optionType = getOptionType(type)
            if (optionType == Constants.PanoOptionType.EnableUploadDebugLogs
                    || optionType == Constants.PanoOptionType.EnableUploadAudioDump
                    || optionType == Constants.PanoOptionType.EnableAudioEarMonitoring
                    || optionType == Constants.PanoOptionType.EnableUploadDebugLogsAtFailure
                    || optionType == Constants.PanoOptionType.EnableCpuAdaption
                    || optionType == Constants.PanoOptionType.ScreenOptimization) {

                val enable = params["option"] as Boolean
                callback.success(engine?.setOption(optionType, enable))

            } else if (optionType == Constants.PanoOptionType.EnablePanoAudioProfile) {

                val optionMap = params["option"] as Map<*, *>
                val audioProfile = RtcAudioProfile().apply {
                    this.sampleRate = getAudioSampleRate((optionMap["sampleRate"] as Number).toInt())
                    this.channel = getAudioChannel((optionMap["channel"] as Number).toInt())
                    this.profileQuality = getAudioProfileQuality((optionMap["profileQuality"] as Number).toInt())
                }
                callback.success(engine?.setOption(optionType, audioProfile))

            } else {
                callback.failure(Constants.QResult.InvalidArgs.name, "setOption Unsupported type($type)")
            }
        }
    }

    override fun snapshotVideo(params: Map<String, *>, callback: Callback) {
        val outputDir = params["outputDir"] as String
        val userId = (params["userId"] as String).toLong()
        val optionMap = params["option"] as Map<*, *>
        val format = (optionMap["format"] as Number).toInt()
        val mirror = optionMap["mirror"] as Boolean
        val result = engine?.snapshotVideo(outputDir, userId,
                RtcSnapshotVideoOption().apply {
                    this.format = getImageFileFormat(format)
                    this.mirror = mirror
                })
        callback.success(result)
    }

    override fun startAudioDumpWithFilePath(params: Map<String, *>, callback: Callback) {
        val maxFileSize = (params["maxFileSize"] as Number).toLong()
        callback.success(engine?.startAudioDump(maxFileSize))
    }

    override fun stopAudioDump(callback: Callback) {
        callback.success(engine?.stopAudioDump())
    }

    override fun sendFeedback(params: Map<String, *>, callback: Callback) {
        val infoMap = params["info"] as Map<*, *>
        val info = RtcEngine.FeedbackInfo().apply {
            this.type = getFeedbackType((infoMap["type"] as Number).toInt())
            this.productName = infoMap["productName"] as String
            this.description = infoMap["detailDescription"] as String
            this.contact = infoMap["contact"] as String
            this.extraInfo = infoMap["extraInfo"] as String
            this.uploadLogs = infoMap["uploadLogs"] as Boolean
        }
        callback.success(engine?.sendFeedback(info))
    }

    override fun createAudioMixingTask(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        val filename = params["filename"] as String
        callback.success(engine?.audioMixingMgr?.createAudioMixingTask(taskId, filename))
    }

    override fun destroyAudioMixingTask(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.destroyAudioMixingTask(taskId))
    }

    override fun startAudioMixingTask(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        val configMap = params["config"] as Map<*, *>
        val config = RtcAudioMixingConfig().apply {
            enablePublish = configMap["enablePublish"] as Boolean
            publishVolume = (configMap["publishVolume"] as Number).toInt()
            enableLoopback = configMap["enableLoopback"] as Boolean
            loopbackVolume = (configMap["loopbackVolume"] as Number).toInt()
            cycle = (configMap["cycle"] as Number).toInt()
            replaceMicrophone = configMap["replaceMicrophone"] as Boolean
        }
        callback.success(engine?.audioMixingMgr?.startAudioMixingTask(taskId, config))
    }

    override fun updateAudioMixingTask(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        val configMap = params["config"] as Map<*, *>
        val config = RtcAudioMixingConfig().apply {
            enablePublish = configMap["enablePublish"] as Boolean
            publishVolume = (configMap["publishVolume"] as Number).toInt()
            enableLoopback = configMap["enableLoopback"] as Boolean
            loopbackVolume = (configMap["loopbackVolume"] as Number).toInt()
            cycle = (configMap["cycle"] as Number).toInt()
            replaceMicrophone = configMap["replaceMicrophone"] as Boolean
        }
        callback.success(engine?.audioMixingMgr?.updateAudioMixingTask(taskId, config))
    }

    override fun stopAudioMixingTask(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.stopAudioMixingTask(taskId))
    }

    override fun resumeAudioMixing(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.resumeAudioMixing(taskId))
    }

    override fun pauseAudioMixing(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.pauseAudioMixing(taskId))
    }

    override fun getAudioMixingDuration(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.getAudioMixingDuration(taskId))
    }

    override fun getAudioMixingCurrentTimestamp(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.getCurrentAudioMixingTimestamp(taskId))
    }

    override fun seekAudioMixing(params: Map<String, *>, callback: Callback) {
        val taskId = (params["taskId"] as Number).toLong()
        val timestampMs = (params["timestampMs"] as Number).toLong()
        callback.success(engine?.audioMixingMgr?.seekAudioMixing(taskId, timestampMs))
    }

    override fun getSdkVersion(callback: Callback) {
        callback.success(engine?.sdkVersion)
    }
}