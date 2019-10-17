package com.marin.plugin;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;
import com.arthenica.mobileffmpeg.FFmpeg;

public class FFMpeg extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {

        if (action.equals("exec")) {
            
            //TODO: call ffmpeg-mobile and do the processing ...
            //FFmpeg.execute("-i file1.mp4 -c:v mpeg4 file2.mp4"); 
            //https://github.com/tanersener/mobile-ffmpeg/wiki/Android
            String name = data.getString(0);
            String message = "Hello, " + name;
            callbackContext.success(message);

            return true;

        } else {
            
            return false;

        }
    }
}
