package video.pano.pano_rtc_example

import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class PanoApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}