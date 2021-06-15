package video.pano.rtc.native

import com.pano.rtc.api.RtcNetworkManager
import video.pano.rtc.native.api.IRtcNetworkManager
import video.pano.rtc.native.events.RtcNetworkManagerEvent

class RtcNetworkMgr(
        emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcNetworkManager {

    private var manager: RtcNetworkManager? = null
    private var event = RtcNetworkManagerEvent(emit)

    fun setInnerMgr(manager: RtcNetworkManager?) {
        this.manager = manager
    }

    override fun startNetworkTest(params: Map<String, *>, callback: Callback) {
        val token = params["token"] as String
        callback.success(manager?.startNetworkTest(token, event))
    }

    override fun stopNetworkTest(params: Map<String, *>, callback: Callback) {
        callback.success(manager?.stopNetworkTest())
    }
}