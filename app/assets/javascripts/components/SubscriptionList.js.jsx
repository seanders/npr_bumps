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
      subscriptions: [],
      masterSubscriptions: []
    };
  },

  componentDidMount: function() {
    var self = this;
    this.getSubscriptionsForPlaylist(this.props.playlistItem).then(function (response) {
      self.setState({
        masterSubscriptions: response,
        subscriptions: _.cloneDeep(response)
      })
    });
  },

  componentWillReceiveProps: function (nextProps) {
    var self = this;
    this.getSubscriptionsForPlaylist(nextProps.playlistItem).then(function (response) {
      self.setState({
        masterSubscriptions: response,
        subscriptions: _.cloneDeep(response)
      })
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

  submitForm: function () {
    console.log('dat shit was submitted');
  },

  render: function() {
    var self = this;
        show = !!this.props.playlistItem ? "show" : 'hide',
        subscriptionItems = this.state.subscriptions.map(function (subscription) {
      return (
        <SubscriptionItem onChangeHandler={self.onChangeHandler} name={subscription.name} programId={subscription.id} key={subscription.id} subscribed={subscription.subscribed} />
      )
    });

    return (
      <div className={"subscription-index "+show}>
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
      </div>
    );
  }

});

module.exports = SubscriptionList;
