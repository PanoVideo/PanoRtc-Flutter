package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcMessageService {

    fun sendMessage(params: Map<String, *>, callback: Callback)

    fun broadcastMessage(params: Map<String, *>, callback: Callback)
}