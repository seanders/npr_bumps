var React = require('react'),
    SubscriptionItem = require('./SubscriptionItem.js.jsx'),
    prBumpsApi = require('../services/prBumpsApi.js'),
    LoadingIcon = require('./LoadingIcon.js.jsx'),
    _ = require('lodash'),
    mui = require('material-ui'),
    RaisedButton = mui.RaisedButton;

var SubscriptionList = React.createClass({
  getInitialState: function () {
    return {
      dirtySubscriptionsForm: false,
      ajaxSuccess: false,
      subscriptions: [],
      masterSubscriptions: []
    };
  },

  setSubscriptionState: function (newSubscriptionArray, ajaxSuccess) {
    this.setState({
      dirtySubscriptionsForm: false,
      masterSubscriptions: newSubscriptionArray,
      subscriptions: _.cloneDeep(newSubscriptionArray),
      ajaxSuccess: ajaxSuccess || false
    })
  },

  componentDidMount: function() {
    var self = this;
    this.getSubscriptionsForPlaylist(this.props.playlistItem).then(function (response) {
      // update state for component
      self.setSubscriptionState(response);
    });
  },

  componentWillReceiveProps: function (nextProps) {
    var self = this;
    this.getSubscriptionsForPlaylist(nextProps.playlistItem).then(function (response) {
      self.setSubscriptionState(response);
    });
  },

  getSubscriptionsForPlaylist: function (playlistItem) {
    var playlistId = playlistItem.id;
    return prBumpsApi.getSubscriptions(playlistId);
  },

  onChangeHandler: function (playlistId, subscribed) {
    // update subscriptions.subscribed value for correct playlist
    var newSubscriptions = this.state.subscriptions;
    var masterSubscriptions = this.state.masterSubscriptions;
    var playlist = _.find(newSubscriptions, {id: playlistId});

    // set value on playlistItem
    playlist.subscribed = subscribed;
    // check if value we are setting is different from original form
    var isFormDirty = this.isSubscriptionFormDirty(masterSubscriptions, newSubscriptions);
    // update state
    this.setState({
      ajaxSuccess: false,
      subscriptions: newSubscriptions,
      dirtySubscriptionsForm: isFormDirty
    });
  },

  cleanForm: function () {
    var master = this.state.masterSubscriptions;
    this.setState({
      subscriptions: _.cloneDeep(master),
      dirtySubscriptionsForm: false
    });
  },

  isSubscriptionFormDirty: function (oldList, newList) {
    return !_.isEqual(oldList, newList);
  },

  submitForm: function (event) {
    var requestPayload = this.createPayloadForSubmit(),
        self = this;

    this.setState({
      ajaxSuccess: false
    });

    prBumpsApi.updateSubscriptionsForPlaylist(requestPayload).then(function (response) {
      self.setSubscriptionState(response, true);
    }, function () {
      console.log('error callback;');
    });
  },

  getPlaylistItemId: function () {
    return this.props.playlistItem.id;
  },

  createPayloadForSubmit: function () {
    var playlistItemId = this.props.playlistItem.id;
    var programIds = _.chain(this.state.subscriptions).map(function (subscription) {
      if(subscription.subscribed) {
        return subscription.id;
      }
    }).compact().value();
    return {
      playlistItemId: playlistItemId,
      programIds: programIds
    }
  },

  render: function() {
    var self = this,
        // extract this shit into a method in a mixin for show/hide ability
        showSubscriptionList = !!this.props.playlistItem ? "show" : 'hide',
        showAjaxSuccess = !!this.state.ajaxSuccess ? "show" : "hide",
        subscriptionItems = this.state.subscriptions.map(function (subscription) {
      return (
        <SubscriptionItem onChangeHandler={self.onChangeHandler} name={subscription.name} programId={subscription.id} key={subscription.id} subscribed={subscription.subscribed} />
      )
    });

    return (
      <div className={"subscription-index "+showSubscriptionList}>
        <div>
          <h3 className="subscription-index--header">{this.props.playlistItem.name}</h3>
        </div>
        <form>
          <input type="hidden" id="playlistId" name="playlistId" value={this.props.playlistItem.id}/>
          {subscriptionItems}
        </form>

        <div className="subscription-index--action-buttons">
          <div className="primary-action-button">
            <RaisedButton
              label="Update Subscription"
              disabled={!this.state.dirtySubscriptionsForm}
              secondary={this.state.dirtySubscriptionsForm}
              onMouseDown={this.submitForm}
            >
            </RaisedButton>
          </div>
          <RaisedButton
            label="Discard Changes"
            onMouseDown={this.cleanForm}
            disabled={!this.state.dirtySubscriptionsForm}>
          </RaisedButton>
        </div>

        <div className={"ajax-success " + showAjaxSuccess}>
          <span className="mui-font-style-body-2">Saved!</span>
        </div>
      </div>
    );
  }

});

module.exports = SubscriptionList;
