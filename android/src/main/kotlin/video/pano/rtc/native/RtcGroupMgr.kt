package video.pano.rtc.native

import com.pano.rtc.api.RtcGroupManager
import video.pano.rtc.native.api.IRtcGroupManager
import video.pano.rtc.native.events.RtcGroupManagerEvent

class RtcGroupMgr(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcGroupManager {

    private var manager: RtcGroupManager? = null

    fun setInnerMgr(manager: RtcGroupManager?) {
        this.manager = manager
        this.manager?.setCallback(RtcGroupManagerEvent { methodName, data ->
            emit(methodName, data)
        })
    }

    override fun joinGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        val config = params["config"] as Map<*, *>
        val userData = config["userData"] as String
        callback.success(manager?.joinGroup(groupId, RtcGroupManager.GroupConfig().apply {
            this.userData = userData
        }))
    }

    override fun subscribeGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.subscribeGroup(groupId))
    }

    override fun unsubscribeGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.unsubscribeGroup(groupId))
    }

    override fun leaveGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.leaveGroup(groupId))
    }

    @Suppress("UNCHECKED_CAST")
    override fun inviteGroupUsers(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        val users = params["users"] as List<String>
        val userIds = LongArray(users.size)
        for (i in users.indices) {
            userIds[i] = users[i].toLong()
        }
        callback.success(manager?.inviteGroupUsers(groupId, userIds))
    }

    override fun dismissGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.dismissGroup(groupId))
    }

    override fun setDefaultGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String?
        callback.success(manager?.setDefaultGroup(groupId))
    }

    override fun observeGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.observeGroup(groupId))
    }

    override fun unobserveGroup(params: Map<String, *>, callback: Callback) {
        val groupId = params["groupId"] as String
        callback.success(manager?.unobserveGroup(groupId))
    }

    override fun observeAllGroups(callback: Callback) {
        callback.success(manager?.observeAllGroups())
    }

    override fun unobserveAllGroups(callback: Callback) {
        callback.success(manager?.unobserveAllGroups())
    }
}