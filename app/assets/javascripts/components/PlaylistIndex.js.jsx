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

  render: function() {
    var playlistItems = this.state.playlists.map(function (playlistItem) {
      return (
        <PlaylistItem name={playlistItem.name} />
      )
    })
    return (
      <div>
        {playlistItems}
      </div>
    );
  }
});

module.exports = PlaylistIndex;
