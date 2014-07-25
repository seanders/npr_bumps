// config
var options = {
    appkeyFile: './spotify_appkey.key',
    cacheFolder: 'cache',
    settingsFolder: 'settings'
};
// require user credentials to get write access to playlist
// TODO: Move these into environment variables
var userCredentials = require('../../config/user_credentials.js');

// rake task should create a temp_file with the song/artist and episode_track_relation_id pairs for search
// require this file into here and loop through the list until all songs have been added to the playlist
//

// instantiate spotify session
var spotify = require('node-spotify')(options);

// code to run after logged in
function ready () {
  getPlaylist(userCredentials.playlistID, function (playlist) {
    getTracksForPlaylist(playlist, log)
  });
};

function getPlaylist (id, callback) {
  var playlist = spotify.createFromLink(id);
  spotify.waitForLoaded([playlist], callback);
};

function log (data) {
  console.log('data:', data);
};

function getTracksForPlaylist (playlist, callback) {
  var allTracks = playlist.getTracks();
  spotify.waitForLoaded(allTracks, function (tracks) {
    console.log(tracks);
  });
};

// execute callback
spotify.on({
  ready: ready
});

spotify.login(userCredentials.email, userCredentials.password, false, false)
// we done here
// process.exit(0);
