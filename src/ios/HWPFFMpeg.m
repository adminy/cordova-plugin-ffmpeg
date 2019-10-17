#import "HWPFFMpeg.h"
#import <mobileffmpeg/MobileFFmpeg.h>

@implementation HWPFFMpeg

- (void)exec:(CDVInvokedUrlCommand*)command
{
    //TODO: call ffmpeg-mobile and do the processing ...
    //[MobileFFmpeg execute: @"-i file1.mp4 -c:v mpeg4 file2.mp4"];
    //https://github.com/tanersener/mobile-ffmpeg/wiki/IOS
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
