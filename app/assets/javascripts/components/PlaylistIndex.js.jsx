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

  componentWillReceiveProps: function(nextProps) {
    if (nextProps.hasOwnProperty('playlists')) this.setState({playlists: nextProps.playlists})
  },

  getSubscriptionsForItem: function (playlistItem) {
    return this.props.containerGetSubscriptionsForItem(playlistItem);
  },

  render: function() {
    var self = this;
    var playlistItems = this.state.playlists.map(function (playlistItem) {
      return (
        <PlaylistItem playlistItem={playlistItem} key={playlistItem.id}  clickHandler={self.getSubscriptionsForItem} />
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
