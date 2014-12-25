$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
  var token;
  if (!options.crossDomain) {
    token = $('meta[name="csrf-token"]').attr('content');
    if (token) {
      return jqXHR.setRequestHeader('XSRF-TOKEN', token);
    }
  }
});

function prBumpsApi () {
  this.getPlaylists = function () {
    return $.post('http://localhost:3000/api/playlists/sync');
  }
}
