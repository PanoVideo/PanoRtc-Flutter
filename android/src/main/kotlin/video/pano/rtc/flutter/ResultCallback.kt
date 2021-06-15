package video.pano.rtc.flutter

import com.pano.rtc.api.Constants
import io.flutter.plugin.common.MethodChannel.Result
import video.pano.rtc.native.Callback

class ResultCallback(private val result: Result?) : Callback() {
    
    override fun success(data: Any?) {
        if (data is Constants.QResult) {
            result?.success(data.value)
        } else {
            if (data == null) {
                failure("NullResult", "")
            } else {
                result?.success(data)
            }
        }
    }

    override fun failure(code: String, message: String) {
        result?.error(code, message, null)
    }
}
