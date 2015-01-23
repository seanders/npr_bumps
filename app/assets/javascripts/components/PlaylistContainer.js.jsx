// Deps
var PlaylistIndex = require("./PlaylistIndex.js.jsx");
var SubscriptionList = require("./SubscriptionList.js.jsx");
var React = require('react');
var _ = require('lodash');

// Component
var PlaylistContainer = React.createClass({
  getInitialState: function () {
    return {
      playlistId: null,
      playlistItem: null
    };
  },

  containerGetSubscriptionsForItem: function (playlistItem) {
    var playlistId = playlistItem.id;
    this.setState({
      playlistId: playlistId,
      playlistItem: playlistItem
    });
  },

  render: function () {
    var playlistRender;
    var subscriptionItems = this.state.subscriptions;
    var playlistItem = this.state.playlistItem;

    if (playlistItem) {
      playlistRender = <SubscriptionList playlistItem={playlistItem}></SubscriptionList>
    } else {
      playlistRender = <h5>No playlist selected!</h5>
    }
    return (
      <div>
        <PlaylistIndex containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}></PlaylistIndex>
        {playlistRender}
      </div>
    )
  }
});

module.exports = PlaylistContainer;
