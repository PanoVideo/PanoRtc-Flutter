package video.pano.rtc.native.events

import com.pano.rtc.api.RtcNetworkManager

class RtcNetworkManagerEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcNetworkManager.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onNetworkTestComplete(quality: RtcNetworkManager.NetworkQuality?) {
        val map = mapOf(
                "rating" to quality?.rating?.value,
                "txLoss" to quality?.txLoss,
                "rxLoss" to quality?.rxLoss,
                "rtt" to quality?.rtt
        )
        callback("onNetworkTestComplete", map)
    }
}