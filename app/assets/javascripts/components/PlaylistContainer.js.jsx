// Deps
var PlaylistIndex = require("./PlaylistIndex.js.jsx");
var SubscriptionList = require("./SubscriptionList.js.jsx");
var React = require('react');

// Component
var PlaylistContainer = React.createClass({
  getInitialState: function () {
    return {
      playlistId: null,
      subscriptions: []
    };
  },

  containerGetSubscriptionsForItem: function (playlistId) {
    var self = this;
    var api = new prBumpsApi();
    api.getSubscriptions(playlistId).then(function (response) {
      self.setState({
        subscriptions: response,
        playlistId: playlistId
      })
    });
  },

  handleClickOnSubscriptionItem: function () {

  },

  render: function () {
    var subscriptionItems = this.state.subscriptions;
    return (
      <div>
        <PlaylistIndex containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}></PlaylistIndex>
        <SubscriptionList items={subscriptionItems} playlistId={this.state.playlistId}></SubscriptionList>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
