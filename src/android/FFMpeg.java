package com.marin.plugin;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;
import com.arthenica.mobileffmpeg.ExecuteCallback;
import com.arthenica.mobileffmpeg.FFmpeg;
import static com.arthenica.mobileffmpeg.Config.RETURN_CODE_SUCCESS;
 // ref: https://github.com/tanersener/mobile-ffmpeg/wiki/Android
public class FFMpeg extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("exec")) {
            FFmpeg.executeAsync(data.getString(0), new ExecuteCallback() {
                @Override
                String result = String.format("Done out=%s", Config.getLastCommandOutput());
                public void apply(long executionId, int returnCode) {
                    if (returnCode == RETURN_CODE_SUCCESS)
                        callbackContext.success(result);
                    else
                        callbackContext.error("Error Code: " + returnCode);
                }
            });
            return true;
        } else return false;
    }
}
