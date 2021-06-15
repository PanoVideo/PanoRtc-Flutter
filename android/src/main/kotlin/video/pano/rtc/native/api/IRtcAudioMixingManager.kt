package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcAudioMixingManager {

    fun createAudioMixingTask(params: Map<String, *>, callback: Callback)

    fun destroyAudioMixingTask(params: Map<String, *>, callback: Callback)

    fun startAudioMixingTask(params: Map<String, *>, callback: Callback)

    fun updateAudioMixingTask(params: Map<String, *>, callback: Callback)

    fun stopAudioMixingTask(params: Map<String, *>, callback: Callback)

    fun resumeAudioMixing(params: Map<String, *>, callback: Callback)

    fun pauseAudioMixing(params: Map<String, *>, callback: Callback)

    fun getAudioMixingDuration(params: Map<String, *>, callback: Callback)

    fun getAudioMixingCurrentTimestamp(params: Map<String, *>, callback: Callback)

    fun seekAudioMixing(params: Map<String, *>, callback: Callback)
}