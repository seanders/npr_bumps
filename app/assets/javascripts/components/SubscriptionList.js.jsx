var React = require('react'),
    SubscriptionItem = require('./SubscriptionItem.js.jsx'),
    mui = require('material-ui'),
    RaisedButton = mui.RaisedButton;

var SubscriptionList = React.createClass({
  onChangeHandler: function (playlistId, subscribed) {
    this.props.clickSubscriptionHandler(playlistId, subscribed);
  },

  render: function() {
    var self = this;
    var subscriptionItems = this.props.items.map(function (subscription) {
      return (
        <SubscriptionItem onChangeHandler={self.onChangeHandler} name={subscription.name} programId={subscription.id} key={subscription.id} subscribed={subscription.subscribed} />
      )
    });

    return (
      <div className="subscription-index">
        <h3>{this.props.playlistName}</h3>
        <form>
          <input type="hidden" id="playlistId" name="playlistId" value={this.props.playlistId}/>
          {subscriptionItems}
        </form>
        <div className="primary-action-button">
          <RaisedButton label="Update Subscription" secondary={true}/>
        </div>
        <RaisedButton label="Discard Changes" />
      </div>
    );
  }

});

module.exports = SubscriptionList;
