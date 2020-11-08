#import "HWPFFMpeg.h"
#import <mobileffmpeg/MobileFFmpeg.h>
#import <mobileffmpeg/MobileFFmpegConfig.h>

@implementation HWPFFMpeg

- (void)exec:(CDVInvokedUrlCommand*)command {
    //https://github.com/tanersener/mobile-ffmpeg/wiki/IOS
    NSString* cmd = [[command arguments] objectAtIndex:0];
    NSString* responseToUser;
    [MobileFFmpeg execute: cmd];

    int returnCode = [MobileFFmpegConfig getLastReturnCode];
    NSString *output = [MobileFFmpegConfig getLastCommandOutput];

    if (returnCode == RETURN_CODE_SUCCESS) {
        responseToUser = [NSString stringWithFormat: @"success out=%@", output];

    } else if (returnCode == RETURN_CODE_CANCEL) {
        responseToUser = [NSString stringWithFormat: @"canceld"];

    } else {
        responseToUser = [NSString stringWithFormat: @"failure code=%d out=%@", returnCode, output];

    }


    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:responseToUser];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
