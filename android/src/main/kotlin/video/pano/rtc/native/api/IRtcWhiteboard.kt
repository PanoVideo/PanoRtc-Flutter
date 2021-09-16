package video.pano.rtc.native.api

import video.pano.rtc.native.Callback

interface IRtcWhiteboard {

    fun setRoleType(params: Map<String, *>, callback: Callback)

    fun open(params: Map<String, *>, callback: Callback)

    fun close(callback: Callback)

    fun leave(callback: Callback)

    fun stop(callback: Callback)

    fun getCurrentWhiteboardId(callback: Callback)

    fun getToolType(callback: Callback)

    fun getCurrentPageNumber(callback: Callback)

    fun getTotalNumberOfPages(callback: Callback)

    fun getCurrentScaleFactor(callback: Callback)

    fun setCurrentScaleFactor(params: Map<String, *>, callback: Callback)

    fun setBackgroundImage(params: Map<String, *>, callback: Callback)

    fun setBackgroundImageWithPage(params: Map<String, *>, callback: Callback)

    fun setBackgroundImageScalingMode(params: Map<String, *>, callback: Callback)

    fun setToolType(params: Map<String, *>, callback: Callback)

    fun setLineWidth(params: Map<String, *>, callback: Callback)

    fun setFillType(params: Map<String, *>, callback: Callback)

    fun setFillColor(params: Map<String, *>, callback: Callback)

    fun setForegroundColor(params: Map<String, *>, callback: Callback)

    fun setBackgroundColor(params: Map<String, *>, callback: Callback)

    fun setFontStyle(params: Map<String, *>, callback: Callback)

    fun setFontSize(params: Map<String, *>, callback: Callback)

    fun addStamp(params: Map<String, *>, callback: Callback)

    fun setStamp(params: Map<String, *>, callback: Callback)

    fun undo(callback: Callback)

    fun redo(callback: Callback)

    fun addPage(params: Map<String, *>, callback: Callback)

    fun insertPage(params: Map<String, *>, callback: Callback)

    fun removePage(params: Map<String, *>, callback: Callback)

    fun gotoPage(params: Map<String, *>, callback: Callback)

    fun nextPage(callback: Callback)

    fun prevPage(callback: Callback)

    fun nextStep(callback: Callback)

    fun prevStep(callback: Callback)

    fun addImageFile(params: Map<String, *>, callback: Callback)
    
    fun addAudioFile(params: Map<String, *>, callback: Callback)

    fun addVideoFile(params: Map<String, *>, callback: Callback)

    fun addBackgroundImages(params: Map<String, *>, callback: Callback)

    fun addH5File(params: Map<String, *>, callback: Callback)

    fun addDoc(params: Map<String, *>, callback: Callback)

    fun addDocWithExtHtml(params: Map<String, *>, callback: Callback)

    fun createDocWithImages(params: Map<String, *>, callback: Callback)

    fun createDocWithFilePath(params: Map<String, *>, callback: Callback)

    fun deleteDoc(params: Map<String, *>, callback: Callback)

    fun switchDoc(params: Map<String, *>, callback: Callback)

    fun saveDocToImages(params: Map<String, *>, callback: Callback)

    fun enumerateFiles(callback: Callback)

    fun getCurrentFileId(callback: Callback)

    fun getFileInfo(params: Map<String, *>, callback: Callback)

    fun sendMessageToExternalHtml(params: Map<String, *>, callback: Callback)

    fun clearContents(params: Map<String, *>, callback: Callback)

    fun clearUserContents(params: Map<String, *>, callback: Callback)

    fun snapshot(params: Map<String, *>, callback: Callback)

    fun initVision(params: Map<String, *>, callback: Callback)
    
    fun resetVision(callback: Callback)

    fun startShareVision(callback: Callback)

    fun stopShareVision(callback: Callback)

    fun startFollowVision(callback: Callback)

    fun stopFollowVision(callback: Callback)

    fun syncVision(callback: Callback)

    fun sendMessage(params: Map<String, *>, callback: Callback)

    fun broadcastMessage(params: Map<String, *>, callback: Callback)

    fun setOption(params: Map<String, *>, callback: Callback)
}