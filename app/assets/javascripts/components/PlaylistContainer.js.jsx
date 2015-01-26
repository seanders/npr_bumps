// Deps
var PlaylistIndex = require("./PlaylistIndex.js.jsx"),
    prBumpsApi = require("../services/prBumpsApi.js"),
    SubscriptionList = require("./SubscriptionList.js.jsx"),
    React = require('react'),
    _ = require('lodash'),
    mui = require("material-ui"),
    RaisedButton = mui.RaisedButton;

// Component
var PlaylistContainer = React.createClass({
  getInitialState: function () {
    return {
      playlistId: null,
      playlistItem: null,
      playlists: []
    };
  },

  containerGetSubscriptionsForItem: function (playlistItem) {
    var playlistId = playlistItem.id;
    this.setState({
      playlistId: playlistId,
      playlistItem: playlistItem
    });
  },

  refreshPlaylistIndex: function () {
    var self = this;
    prBumpsApi.getPlaylists().then(function (response) {
      self.setState({
        playlists: response
      })
    });
  },

  render: function () {
    var playlistRender;
    var subscriptionItems = this.state.subscriptions;
    var playlistItem = this.state.playlistItem;

    if (playlistItem) {
      playlistRender = <SubscriptionList playlistItem={playlistItem}></SubscriptionList>
    } else {
      playlistRender = <div className="subscription-index"><h3>No playlist selected!</h3></div>
    }
    return (
      <div>
        {/* Row 2 */}
        <div className="refresh-button">
          <RaisedButton
            label="Refresh Playlists"
            onMouseDown={this.refreshPlaylistIndex}>
          </RaisedButton>
        </div>

        {/* Row 1 */}
        <div className="playlist-manager-row">
          <PlaylistIndex 
            containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}
            playlists={this.state.playlists}
            >
          </PlaylistIndex>
          {playlistRender}
        </div>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
