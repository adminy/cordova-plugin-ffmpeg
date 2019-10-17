/*global cordova, module*/

module.exports = {
    exec: function (cmd, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "FFMpeg", "exec", [cmd]);
    }
};
