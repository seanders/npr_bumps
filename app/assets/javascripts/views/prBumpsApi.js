$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
  var token;
  if (!options.crossDomain) {
    token = $('meta[name="csrf-token"]').attr('content');
    if (token) {
      return jqXHR.setRequestHeader('XSRF-TOKEN', token);
    }
  }
});

function prBumpsApi (env) {
  var endpoint = env || 'http://localhost:3000/api/';

  this.getPlaylists = function () {
    return $.post(endpoint +'playlists/sync');
  },

  this.getSubscriptions = function (id) {
    return $.get(endpoint + "playlists/"+id+"/subscriptions");
  }
}
