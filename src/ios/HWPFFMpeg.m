#import "HWPFFMpeg.h"
#import <mobileffmpeg/MobileFFmpeg.h>
#import <mobileffmpeg/MobileFFmpegConfig.h>

@implementation HWPFFMpeg

NSMutableDictionary *mappings;


- (void)exec:(CDVInvokedUrlCommand*)command {
    
    if (mappings == nil){
        mappings = [NSMutableDictionary new];
    }
    
    //https://github.com/tanersener/mobile-ffmpeg/wiki/IOS
    NSString* cmd = [[command arguments] objectAtIndex:0];
    long executionId = [MobileFFmpeg executeAsync:cmd withCallback:self];
    [mappings setValue:command.callbackId forKey:[NSString stringWithFormat:@"%li", executionId]];

}

- (void)probe:(CDVInvokedUrlCommand*)command {
    NSString* filePath = [[command arguments] objectAtIndex:0];
    MediaInformation *mediaInformation = [MobileFFprobe getMediaInformation:filePath];
    int returnCode = [MobileFFmpegConfig getLastReturnCode];

    if(returnCode == RETURN_CODE_SUCCESS) {
        CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsDictionary:[mediaInformation getAllProperties]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus:CDVCommandStatus_ERROR
                                   messageAsString:[MobileFFmpegConfig getLastCommandOutput]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}


- (void)executeCallback:(long)executionId :(int)returnCode {
    NSString* responseToUser;
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

    [self.commandDelegate sendPluginResult:result callbackId:[mappings valueForKey:[NSString stringWithFormat:@"%li", executionId]]];
    [mappings removeObjectForKey:[NSString stringWithFormat:@"%li", executionId]];
}

@end
