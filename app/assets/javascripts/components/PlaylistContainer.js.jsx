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
      dirtySubscriptionsForm: false,
      subscriptions: [],
      masterSubscriptions: []
    };
  },

  containerGetSubscriptionsForItem: function (playlistItem) {
    var playlistId = playlistItem.id;
        self = this,
        api = new prBumpsApi();

    api.getSubscriptions(playlistId).then(function (response) {
      self.setState({
        masterSubscriptions: response,
        subscriptions: _.cloneDeep(response),
        playlistId: playlistId,
        playlistItem: playlistItem
      })
    });
  },

  isSubscriptionFormDirty: function (oldList, newList) {
    return !_.isEqual(oldList, newList);
  },

  handleClickOnSubscriptionItem: function (playlistId, subscribed) {
    // update subscriptions.subscribed value for correct playlist
    var newSubscriptions = this.state.subscriptions;
    var masterSubscriptions = this.state.masterSubscriptions;
    var playlist = _.find(newSubscriptions, {id: playlistId});

    // set value on playlistItem
    playlist.subscribed = subscribed;
    // check if value we are setting is different from original form
    var dirtyForm = this.isSubscriptionFormDirty(masterSubscriptions, newSubscriptions);
    // update state
    this.setState({
      subscriptions: newSubscriptions,
      dirtySubscriptionsForm: dirtyForm
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
