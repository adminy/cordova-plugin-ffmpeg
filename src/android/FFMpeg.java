package com.marin.plugin;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;
import com.arthenica.mobileffmpeg.Config;
import com.arthenica.mobileffmpeg.ExecuteCallback;
import com.arthenica.mobileffmpeg.FFmpeg;
import com.arthenica.mobileffmpeg.FFprobe;
import com.arthenica.mobileffmpeg.MediaInformation;
import com.arthenica.mobileffmpeg.Statistics;
import com.arthenica.mobileffmpeg.StatisticsCallback;

import static com.arthenica.mobileffmpeg.Config.RETURN_CODE_SUCCESS;
 // ref: https://github.com/tanersener/mobile-ffmpeg/wiki/Android
public class FFMpeg extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("exec")) {
            FFmpeg.executeAsync(data.getString(0), new ExecuteCallback() {
                @Override
                public void apply(long executionId, int returnCode) {
                    String result = String.format("Done out=%s", Config.getLastCommandOutput());
                    if (returnCode == RETURN_CODE_SUCCESS)
                        callbackContext.success(result);
                    else
                        callbackContext.error("Error Code: " + returnCode);
                }
            });
            return true;
        } else if(action.equals("probe")) {
            MediaInformation info = FFprobe.getMediaInformation(data.getString(0));
            int returnCode = Config.getLastReturnCode();
            if(returnCode == RETURN_CODE_SUCCESS) {
                callbackContext.success(info.getAllProperties());
            } else {
                callbackContext.error(Config.getLastCommandOutput());
            }
            return true;
        } else return false;
    }
}
