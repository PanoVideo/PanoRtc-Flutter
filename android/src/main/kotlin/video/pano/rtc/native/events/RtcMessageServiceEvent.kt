package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.RtcMessageService

class RtcMessageServiceEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcMessageService.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onUserMessage(userId: Long, data: ByteArray?) {
        callback("onUserMessage", userId.toString(), data)
    }

    override fun onServiceStateChanged(state: Constants.MessageServiceState?, reason: Constants.QResult?) {
        callback("onServiceStateChanged", state?.ordinal, reason?.value)
    }
}