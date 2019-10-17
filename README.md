# Cordova FFMPEG (mp3) Plugin

Simple plugin that binds mobile ffmpeg to execute ffmpeg commands

## Using

Create a new Cordova Project

    $ cordova create hello com.example.helloapp Hello
    
Install the plugin

    $ cd hello
    $ cordova plugin add https://github.com/adminy/cordova-plugin-ffmpeg.git
    

Edit `www/js/index.js` and add the following code inside `onDeviceReady`

```js
    ffmpeg.exec("-i someinput.mp4 -vn -c:a copy out.mp3", success => alert(success), failure => alert(failure));
```

Make sure you have the files that will be required by ffmpeg

Install iOS or Android platform

    cordova platform add ios
    cordova platform add android
    
Run the code

    cordova run
