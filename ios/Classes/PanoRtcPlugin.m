#import "PanoRtcPlugin.h"
#if __has_include(<pano_rtc/pano_rtc-Swift.h>)
#import <pano_rtc/pano_rtc-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pano_rtc-Swift.h"
#endif

@implementation PanoRtcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPanoRtcPlugin registerWithRegistrar:registrar];
}
@end
