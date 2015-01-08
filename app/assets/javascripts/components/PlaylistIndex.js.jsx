// Deps
var React = require('react');
var PlaylistItem = require('./PlaylistItem.js.jsx')

// Component
var PlaylistIndex = React.createClass({

  getInitialState: function () {
    return {
      playlists: $('#playlist-panel').data('playlists')
    }
  },

  getSubscriptionsForItem: function (playlistId) {
    return this.props.containerGetSubscriptionsForItem(playlistId);
  },

  render: function() {
    var self = this;
    var playlistItems = this.state.playlists.map(function (playlistItem) {
      return (
        <PlaylistItem name={playlistItem.name} key={playlistItem.id} playlist={playlistItem} playlistId={playlistItem.id} getSubscriptions={self.getSubscriptionsForItem} />
      )
    });

    return (
      <div className="playlist-index">
        {playlistItems}
      </div>
    );
  }
});

module.exports = PlaylistIndex;
