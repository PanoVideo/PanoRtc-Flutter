package video.pano.rtc.native.api

import com.pano.rtc.api.PanoAnnotation
import video.pano.rtc.native.RtcAnnotation

interface IRtcAnnotationCreator {
    fun createAnnotation(annotationId: String, panoAnnotation: PanoAnnotation?): RtcAnnotation?
}