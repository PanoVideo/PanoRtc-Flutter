package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcMessageService {

    fun setProperty(params: Map<String, *>, callback: Callback)

    fun sendMessage(params: Map<String, *>, callback: Callback)

    fun broadcastMessage(params: Map<String, *>, callback: Callback)

    fun publish(params: Map<String, *>, callback: Callback)

    fun subscribe(params: Map<String, *>, callback: Callback)

    fun unsubscribe(params: Map<String, *>, callback: Callback)
}