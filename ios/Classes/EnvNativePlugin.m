#import "EnvNativePlugin.h"
#if __has_include(<env_native/env_native-Swift.h>)
#import <env_native/env_native-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "env_native-Swift.h"
#endif

@implementation EnvNativePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEnvNativePlugin registerWithRegistrar:registrar];
}
@end
