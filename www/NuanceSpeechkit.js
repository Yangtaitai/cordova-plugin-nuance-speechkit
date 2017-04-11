
var exec = require('cordova/exec');

var PLUGIN_NAME = 'NuanceSpeechkitPlugin';

var NuanceSpeechkitPlugin = {
  recognize: function(cb) {
     exec(cb, null, PLUGIN_NAME, 'recognize', null);
  },
  getState: function(cb) {
     exec(cb, null, PLUGIN_NAME, 'getState', null);
  },
  getResult: function(cb) {
     exec(cb, null, PLUGIN_NAME, 'getResult', null);
  },
  stopRecording: function(cb) {
     exec(cb, null, PLUGIN_NAME, 'stopRecording', null);
  },
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  }
};

module.exports = NuanceSpeechkitPlugin;
