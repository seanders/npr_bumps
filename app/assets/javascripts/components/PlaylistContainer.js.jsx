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
      playlistItem: {}
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
    var subscriptionItems = this.state.subscriptions;
    var playlistItem = this.state.playlistItem;
    return (
      <div>
        <PlaylistIndex containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}></PlaylistIndex>
        <SubscriptionList playlistItem={playlistItem}></SubscriptionList>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
