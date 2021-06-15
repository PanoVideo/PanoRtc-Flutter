package video.pano.rtc.native

abstract class Callback {

    abstract fun success(data: Any?)

    abstract fun failure(code: String, message: String)
}