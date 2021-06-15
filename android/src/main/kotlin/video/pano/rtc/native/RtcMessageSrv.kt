package video.pano.rtc.native

import com.pano.rtc.api.RtcMessageService
import video.pano.rtc.native.api.IRtcMessageService
import video.pano.rtc.native.events.RtcMessageServiceEvent

class RtcMessageSrv(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcMessageService {
    private var service: RtcMessageService? = null

    fun setInnerMgr(service: RtcMessageService?) {
        this.service = service
        this.service?.setCallback(RtcMessageServiceEvent { methodName, data ->
            emit(methodName, data)
        })
    }

    override fun sendMessage(params: Map<String, *>, callback: Callback) {
        val message = params["message"] as ByteArray
        val userId = (params["userId"] as String).toLong()
        callback.success(service?.sendMessage(userId, message))
    }

    override fun broadcastMessage(params: Map<String, *>, callback: Callback) {
        val message = params["message"] as ByteArray
        val sendBack = params["sendBack"] as Boolean
        callback.success(service?.broadcastMessage(message, sendBack))
    }
}