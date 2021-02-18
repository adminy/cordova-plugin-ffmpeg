# Cordova FFMPEG Plugin

Simple plugin that binds mobile ffmpeg to execute ffmpeg commands

## Using

Create a new Cordova Project

    $ cordova create hello com.example.helloapp Hello

make sure you have cocoapods **On MacOS**

> `sudo gem install cocoapods`

Install the plugin

    $ cd hello
    $ cordova plugin add https://github.com/adminy/cordova-plugin-ffmpeg.git

Edit `www/js/index.js` and add the following code inside `onDeviceReady`

```js
ffmpeg.exec("-i someinput.mp4 -vn -c:a copy out.mp3", (success) => alert(success), (failure) => alert(failure));
```

Make sure you have the files that will be required by ffmpeg

You can also run the `FFProbe` command to get video information:

```js
ffmpeg.probe(
  "somefile.mp4",
  (result) => {
    console.log("Video details:");
    console.log(result.format.bit_rate);
    console.log(result.format.duration);
    console.log(result.format.filename);
    console.log(result.format.format_name);
    console.log(result.format.nb_programs);
    console.log(result.format.nb_streams);
    console.log(result.format.probe_score);
    console.log(result.format.size);
    console.log(result.format.start_time);

    // You also get details about the video/audio streams of the file
    console.log(result.streams[0].codec_name); // e.g. h264
    console.log(result.streams[0].codec_type); // e.g. 'video'
    console.log(result.streams[1].codec_name); // e.g. aac
    console.log(result.streams[1].codec_type); // e.g. 'audio'
  },
  (error) => alert(error)
);
```

Install iOS or Android platform

    cordova platform add ios
    cordova platform add android

Run the code

    cordova run
