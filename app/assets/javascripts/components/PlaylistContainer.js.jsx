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

  handleClickOnSubscriptionItem: function (playlistId, subscribed) {
    // update subscriptions.subscribed value for correct playlist
    var subscriptions = this.state.subscriptions;
    var playlist = _.find(subscriptions, {id: playlistId});
    playlist.subscribed = subscribed;
    this.setState({
      subscriptions: subscriptions
    });
  },

  render: function () {
    var subscriptionItems = this.state.subscriptions;
    return (
      <div>
        <PlaylistIndex containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}></PlaylistIndex>
        <SubscriptionList clickSubscriptionHandler={this.handleClickOnSubscriptionItem} items={subscriptionItems} playlistId={this.state.playlistId}></SubscriptionList>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
