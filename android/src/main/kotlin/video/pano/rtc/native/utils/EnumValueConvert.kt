package video.pano.rtc.native.utils

import com.pano.rtc.api.Constants
import java.lang.IllegalArgumentException

class EnumValueConvert {
    companion object StaticParams {

        //RtcEngine
        fun getVideoProfileType(type: Int): Constants.VideoProfileType {
            when (type) {
                0 -> {
                    return Constants.VideoProfileType.Lowest
                }
                1 -> {
                    return Constants.VideoProfileType.Low
                }
                2 -> {
                    return Constants.VideoProfileType.Standard
                }
                3 -> {
                    return Constants.VideoProfileType.HD720P
                }
                4 -> {
                    return Constants.VideoProfileType.HD1080P
                }
            }
            return Constants.VideoProfileType.Lowest
        }

        fun getAudioDeviceType(type: Int): Constants.AudioDeviceType {
            when (type) {
                0 -> {
                    return Constants.AudioDeviceType.Unknown
                }
                1 -> {
                    return Constants.AudioDeviceType.Record
                }
                2 -> {
                    return Constants.AudioDeviceType.Playout
                }
            }
            return Constants.AudioDeviceType.Unknown
        }

        fun getImageFileFormat(type: Int): Constants.ImageFileFormat {
            when (type) {
                0 -> {
                    return Constants.ImageFileFormat.JPEG
                }
                1 -> {
                    return Constants.ImageFileFormat.PNG
                }
                2 -> {
                    return Constants.ImageFileFormat.BMP
                }
            }
            return Constants.ImageFileFormat.JPEG
        }

        fun getOptionType(type: Int): Constants.PanoOptionType {
            when (type) {
                1 -> {
                    return Constants.PanoOptionType.EnableUploadDebugLogs
                }
                2 -> {
                    return Constants.PanoOptionType.EnableUploadAudioDump
                }
                6 -> {
                    return Constants.PanoOptionType.EnableAudioEarMonitoring
                }
                7 -> {
                    return Constants.PanoOptionType.PanoOptionBuiltinTransform
                }
                8 -> {
                    return Constants.PanoOptionType.EnableUploadDebugLogsAtFailure
                }
                9 -> {
                    return Constants.PanoOptionType.EnableCpuAdaption
                }
                10 -> {
                    return Constants.PanoOptionType.EnablePanoAudioProfile
                }
                11 -> {
                    return Constants.PanoOptionType.VideoQuadTransform
                }
                17 -> {
                    return Constants.PanoOptionType.ScreenOptimization
                }
            }
            throw IllegalArgumentException("Unsupported OptionType($type)")
        }

        fun getAudioSampleRate(type: Int): Constants.PanoAudioSampleRate {
            when (type) {
                16000 -> {
                    return Constants.PanoAudioSampleRate.AudioSampleRate16KHz
                }
                48000 -> {
                    return Constants.PanoAudioSampleRate.AudioSampleRate48KHz
                }
            }
            return Constants.PanoAudioSampleRate.AudioSampleRate48KHz
        }

        fun getAudioChannel(type: Int): Constants.PanoAudioChannel {
            when (type) {
                1 -> {
                    return Constants.PanoAudioChannel.Mono
                }
                2 -> {
                    return Constants.PanoAudioChannel.Stereo
                }
            }
            return Constants.PanoAudioChannel.Mono
        }

        fun getAudioProfileQuality(type: Int): Constants.PanoAudioProfileQuality {
            when (type) {
                0 -> {
                    return Constants.PanoAudioProfileQuality.Default
                }
                1 -> {
                    return Constants.PanoAudioProfileQuality.High
                }
            }
            return Constants.PanoAudioProfileQuality.Default
        }

        fun getAudioEqualizationMode(type: Int): Constants.AudioEqualizationMode {
            when (type) {
                0 -> {
                    return Constants.AudioEqualizationMode.None
                }
                1 -> {
                    return Constants.AudioEqualizationMode.Bass
                }
                2 -> {
                    return Constants.AudioEqualizationMode.Loud
                }
                3 -> {
                    return Constants.AudioEqualizationMode.VocalMusic
                }
                4 -> {
                    return Constants.AudioEqualizationMode.Strong
                }
                5 -> {
                    return Constants.AudioEqualizationMode.Pop
                }
                6 -> {
                    return Constants.AudioEqualizationMode.Live
                }
                7 -> {
                    return Constants.AudioEqualizationMode.DanceMusic
                }
                8 -> {
                    return Constants.AudioEqualizationMode.Club
                }
                9 -> {
                    return Constants.AudioEqualizationMode.Soft
                }
                10 -> {
                    return Constants.AudioEqualizationMode.Rock
                }
                11 -> {
                    return Constants.AudioEqualizationMode.Party
                }
                12 -> {
                    return Constants.AudioEqualizationMode.Classical
                }
                13 -> {
                    return Constants.AudioEqualizationMode.Test
                }
            }
            return Constants.AudioEqualizationMode.None
        }

        fun getAudioReverbMode(type: Int): Constants.AudioReverbMode {
            when (type) {
                0 -> {
                    return Constants.AudioReverbMode.None
                }
                1 -> {
                    return Constants.AudioReverbMode.VocalI
                }
                2 -> {
                    return Constants.AudioReverbMode.VocalII
                }
                3 -> {
                    return Constants.AudioReverbMode.Bathroom
                }
                4 -> {
                    return Constants.AudioReverbMode.SmallRoomBright
                }
                5 -> {
                    return Constants.AudioReverbMode.SmallRoomDark
                }
                6 -> {
                    return Constants.AudioReverbMode.MediumRoom
                }
                7 -> {
                    return Constants.AudioReverbMode.LargeRoom
                }
                8 -> {
                    return Constants.AudioReverbMode.ChurchHall
                }
                9 -> {
                    return Constants.AudioReverbMode.Cathedral
                }
            }
            return Constants.AudioReverbMode.None
        }

        fun getVideoFrameRateType(type: Int): Constants.VideoFrameRateType {
            when (type) {
                0 -> {
                    return Constants.VideoFrameRateType.Low
                }
                1 -> {
                    return Constants.VideoFrameRateType.Standard
                }
            }
            return Constants.VideoFrameRateType.Low
        }

        fun getFeedbackType(type: Int): Constants.FeedbackType {
            when (type) {
                -1 -> {
                    return Constants.FeedbackType.Unknown
                }
                0 -> {
                    return Constants.FeedbackType.General
                }
                1 -> {
                    return Constants.FeedbackType.Audio
                }
                2 -> {
                    return Constants.FeedbackType.Video
                }
                3 -> {
                    return Constants.FeedbackType.Whiteboard
                }
                4 -> {
                    return Constants.FeedbackType.Screen
                }
            }
            return Constants.FeedbackType.General
        }

        //whiteboard
        fun getWBRoleType(type: Int): Constants.WBRoleType {
            when (type) {
                0 -> {
                    return Constants.WBRoleType.Admin
                }
                1 -> {
                    return Constants.WBRoleType.Attendee
                }
                2 -> {
                    return Constants.WBRoleType.Viewer
                }
            }
            return Constants.WBRoleType.Viewer
        }


        fun getWBImageScalingMode(type: Int): Constants.WBImageScalingMode {
            when (type) {
                0 -> {
                    return Constants.WBImageScalingMode.Fit
                }
                1 -> {
                    return Constants.WBImageScalingMode.AutoFill
                }
                2 -> {
                    return Constants.WBImageScalingMode.FillWidth
                }
                3 -> {
                    return Constants.WBImageScalingMode.FillHeight
                }
            }
            return Constants.WBImageScalingMode.Fit
        }

        fun getWBToolType(type: Int): Constants.WBToolType {
            when (type) {
                0 -> {
                    return Constants.WBToolType.None
                }
                1 -> {
                    return Constants.WBToolType.Select
                }
                2 -> {
                    return Constants.WBToolType.Path
                }
                3 -> {
                    return Constants.WBToolType.Line
                }
                4 -> {
                    return Constants.WBToolType.Rect
                }
                5 -> {
                    return Constants.WBToolType.Ellipse
                }
                6 -> {
                    return Constants.WBToolType.Image
                }
                7 -> {
                    return Constants.WBToolType.Text
                }
                8 -> {
                    return Constants.WBToolType.Eraser
                }
                9 -> {
                    return Constants.WBToolType.Brush
                }
                10 -> {
                    return Constants.WBToolType.Arrow
                }
            }
            return Constants.WBToolType.None
        }

        fun getWBFillType(type: Int): Constants.WBFillType {
            when (type) {
                0 -> {
                    return Constants.WBFillType.None
                }
                1 -> {
                    return Constants.WBFillType.Color
                }
            }
            return Constants.WBFillType.None
        }

        fun getWBFontStyle(type: Int): Constants.WBFontStyle {
            when (type) {
                0 -> {
                    return Constants.WBFontStyle.Normal
                }
                1 -> {
                    return Constants.WBFontStyle.Bold
                }
                2 -> {
                    return Constants.WBFontStyle.Italic
                }
                3 -> {
                    return Constants.WBFontStyle.BoldItalic
                }
            }
            return Constants.WBFontStyle.Normal
        }

        fun getWBSnapshotMode(type: Int): Constants.WBSnapshotMode {
            when (type) {
                0 -> {
                    return Constants.WBSnapshotMode.View
                }
                1 -> {
                    return Constants.WBSnapshotMode.All
                }
            }
            return Constants.WBSnapshotMode.View
        }

        fun getWBClearType(type: Int): Constants.WBClearType {
            when (type) {
                1 -> {
                    return Constants.WBClearType.Draws
                }
                2 -> {
                    return Constants.WBClearType.BackgroundImage
                }
                255 -> {
                    return Constants.WBClearType.All
                }
            }
            return Constants.WBClearType.All
        }
        
        fun getWBDocConvertType(type: Int): Constants.WBDocConvertType {
            when (type) {
                1 -> {
                    return Constants.WBDocConvertType.JPG
                }
                2 -> {
                    return Constants.WBDocConvertType.PNG
                }
                3 -> {
                    return Constants.WBDocConvertType.H5
                }
            }
            return Constants.WBDocConvertType.JPG
        }
    }
}