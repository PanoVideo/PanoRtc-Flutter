package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcNetworkManager {

    fun startNetworkTest(params: Map<String, *>, callback: Callback)

    fun stopNetworkTest(params: Map<String, *>, callback: Callback)
}