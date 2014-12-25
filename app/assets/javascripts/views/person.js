// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () {
  var syncPlaylistsButton = $('#sync-playlists');
  syncPlaylistsButton.on('click', function (event) {
    event.preventDefault();
    var api = new prBumpsApi();
    api.getPlaylists().then(function (response) {
      debugger;
    });
  });

})
