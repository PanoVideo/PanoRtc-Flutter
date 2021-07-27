package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.RtcMessageService
import com.pano.rtc.api.model.RtcPropertyAction

class RtcMessageServiceEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcMessageService.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onServiceStateChanged(state: Constants.MessageServiceState?, reason: Constants.QResult?) {
        callback("onServiceStateChanged", state?.ordinal, reason?.value)
    }

    override fun onUserMessage(userId: Long, data: ByteArray?) {
        callback("onUserMessage", userId.toString(), data)
    }

    override fun onTopicMessage(topic: String?, userId: Long, data: ByteArray?) {
        callback("onTopicMessage", topic, userId.toString(), data)
    }

    override fun onSubscribeResult(topic: String?, result: Constants.QResult?) {
        callback("onSubscribeResult", topic, result?.value)
    }

    override fun onPropertyChanged(props: Array<out RtcPropertyAction>?) {
        val propList = ArrayList<Map<String, *>>()
        props?.forEach {
            propList.add(hashMapOf(
                    "type" to it.actionType.value,
                    "propName" to it.propName,
                    "propValue" to it.propValue
            ))
        }
        callback("onPropertyChanged", propList)
    }
}