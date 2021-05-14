#import "TelesoftasxStoragePlugin.h"
#if __has_include(<telesoftasx_storage/telesoftasx_storage-Swift.h>)
#import <telesoftasx_storage/telesoftasx_storage-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "telesoftasx_storage-Swift.h"
#endif

@implementation TelesoftasxStoragePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTelesoftasxStoragePlugin registerWithRegistrar:registrar];
}
@end
