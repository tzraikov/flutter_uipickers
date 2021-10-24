#import "UIPickersPlugin.h"
#if __has_include(<uipickers/uipickers-Swift.h>)
#import <uipickers/uipickers-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uipickers-Swift.h"
#endif

@implementation UIPickersPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUIPickersPlugin registerWithRegistrar:registrar];
}
@end
