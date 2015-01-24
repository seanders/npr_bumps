$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
  var token;
  if (!options.crossDomain) {
    token = $('meta[name="csrf-token"]').attr('content');
    if (token) {
      return jqXHR.setRequestHeader('XSRF-TOKEN', token);
    }
  }
});

var endpoint = '/api/';

var prBumpsApi = {

  getPlaylists: function () {
    return $.post(endpoint +'playlists/sync');
  },

  getSubscriptions: function (id) {
    return $.get(endpoint + "playlists/"+id+"/subscriptions");
  }
}

module.exports = prBumpsApi;
