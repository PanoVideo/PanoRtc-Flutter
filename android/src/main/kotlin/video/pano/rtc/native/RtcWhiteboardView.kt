package video.pano.rtc.native

import android.content.Context
import com.pano.rtc.api.PanoCoursePageView
import video.pano.rtc.native.Callback as BCallback

class RtcWhiteboardView(context: Context) : PanoCoursePageView(context) {

    fun open(engine: RtcWhiteboardEngine?, params: Map<String, *>, callback: BCallback) {
        engine?.open(params, callback)
    }

    fun startAnnotation(annotation: RtcAnnotation?, params: Map<String, *>, callback: BCallback) {
        annotation?.startAnnotation(params, callback)
    }
}