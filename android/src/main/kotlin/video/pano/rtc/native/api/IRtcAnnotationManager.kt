package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcAnnotationManager {

    fun getVideoAnnotation(params: Map<String, *>, callback: Callback)

    fun getShareAnnotation(params: Map<String, *>, callback: Callback)
}