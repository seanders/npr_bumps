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
  },

  updateSubscriptionsForPlaylist: function (payload) {
    return $.ajax({
      type: "PUT",
      url: endpoint+"playlists/"+payload.playlistItemId+"/subscriptions",
      data: {program_ids: payload.programIds}
    });
  }
}

module.exports = prBumpsApi;
