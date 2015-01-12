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
      playlistItem: {},
      subscriptions: []
    };
  },

  containerGetSubscriptionsForItem: function (playlistItem) {
    var playlistId = playlistItem.id;
        self = this,
        api = new prBumpsApi();

    api.getSubscriptions(playlistId).then(function (response) {
      self.setState({
        subscriptions: response,
        playlistId: playlistId,
        playlistItem: playlistItem
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
    var playlistItem = this.state.playlistItem;
    return (
      <div>
        <PlaylistIndex containerGetSubscriptionsForItem={this.containerGetSubscriptionsForItem}></PlaylistIndex>
        <SubscriptionList playlistName={playlistItem.name} clickSubscriptionHandler={this.handleClickOnSubscriptionItem} items={subscriptionItems} playlistId={playlistItem.id}></SubscriptionList>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
