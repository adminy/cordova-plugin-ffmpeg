#import <Cordova/CDV.h>
#import <mobileffmpeg/MobileFFmpeg.h>

@interface HWPFFMpeg : CDVPlugin<ExecuteDelegate>

- (void) exec:(CDVInvokedUrlCommand*)command;
- (void) probe:(CDVInvokedUrlCommand*)command;

@end
