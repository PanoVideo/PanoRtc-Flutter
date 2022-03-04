package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.RtcGroupManager

class RtcGroupManagerEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
): RtcGroupManager.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onGroupJoinConfirm(groupId: String?, result: Constants.QResult?) {
        callback("onGroupJoinConfirm", groupId, result?.value)
    }

    override fun onGroupLeaveIndication(groupId: String?, reason: Constants.QResult?) {
        callback("onGroupLeaveIndication", groupId, reason?.value)
    }

    override fun onGroupInviteIndication(groupId: String?, fromUserId: Long) {
        callback("onGroupInviteIndication", groupId, fromUserId.toString())
    }

    override fun onGroupDismissConfirm(groupId: String?, result: Constants.QResult?) {
        callback("onGroupDismissConfirm", groupId, result?.value)
    }

    override fun onGroupUserLeaveIndication(groupId: String?, userId: Long, reason: Constants.QResult?) {
        callback("onGroupUserLeaveIndication", groupId, userId.toString(), reason?.value)
    }

    override fun onGroupUserJoinIndication(groupId: String?, userInfo: RtcGroupManager.UserInfo?) {
        val map = mapOf(
                "userId" to userInfo?.userId.toString(),
                "userData" to userInfo?.userData
        )
        callback("onGroupUserJoinIndication", groupId, map)
    }

    override fun onGroupDefaultUpdateIndication(groupId: String?) {
        callback("onGroupDefaultUpdateIndication", groupId)
    }

    override fun onGroupObserveConfirm(groupId: String?, result: Constants.QResult?) {
        callback("onGroupObserveConfirm", groupId, result?.value)
    }
}