package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcAnnotation {

    fun startAnnotation(params: Map<String, *>, callback: Callback)

    fun stopAnnotation(callback: Callback)

    fun setVisible(params: Map<String, *>, callback: Callback)

    fun setRoleType(params: Map<String, *>, callback: Callback)

    fun setToolType(params: Map<String, *>, callback: Callback)

    fun setLineWidth(params: Map<String, *>, callback: Callback)

    fun setColor(params: Map<String, *>, callback: Callback)

    fun setFontStyle(params: Map<String, *>, callback: Callback)

    fun clearContents(params: Map<String, *>, callback: Callback)

    fun clearUserContents(params: Map<String, *>, callback: Callback)

    fun undo(callback: Callback)

    fun redo(callback: Callback)

    fun snapshot(params: Map<String, *>, callback: Callback)
}