package video.pano.rtc.native.api

import com.pano.rtc.api.*
import video.pano.rtc.native.*

interface IRtcManagerCreator {

    fun createWhiteboardEngine(whiteboardId: String, whiteboard: RtcWhiteboard?): RtcWhiteboardEngine?

    fun createAnnotationMgr(manager: PanoAnnotationManager?): RtcAnnotationMgr?

    fun createNetworkMgr(manager: RtcNetworkManager?): RtcNetworkMgr?

    fun createVideoStreamMgr(manager: RtcVideoStreamManager?): RtcVideoStreamMgr?

    fun createRtcMessageSrv(service: RtcMessageService?): RtcMessageSrv?
}