package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcGroupManager {

    fun joinGroup(params: Map<String, *>, callback: Callback)

    fun subscribeGroup(params: Map<String, *>, callback: Callback)

    fun unsubscribeGroup(params: Map<String, *>, callback: Callback)

    fun leaveGroup(params: Map<String, *>, callback: Callback)

    fun inviteGroupUsers(params: Map<String, *>, callback: Callback)

    fun dismissGroup(params: Map<String, *>, callback: Callback)

    fun setDefaultGroup(params: Map<String, *>, callback: Callback)

    fun observeGroup(params: Map<String, *>, callback: Callback)

    fun unobserveGroup(params: Map<String, *>, callback: Callback)
    
    fun observeAllGroups(callback: Callback)
    
    fun unobserveAllGroups(callback: Callback)
}