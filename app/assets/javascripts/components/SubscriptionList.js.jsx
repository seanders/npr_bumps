var React = require('react');
var SubscriptionItem = require('./SubscriptionItem.js.jsx')

var SubscriptionList = React.createClass({
  render: function() {
    var subscriptionItems = this.props.items.map(function (subscription) {
      return (
        <SubscriptionItem name={subscription.name} programId={subscription.id} key={subscription.id} subscribed={subscription.subscribed} />
      )
    });
    return (
      <div className="subscription-index">
        <h1>{this.props.name}</h1>
        <input type="hidden" id="playlistId" name="playlistId" value={this.props.playlistId}/>
        {subscriptionItems}
        <button>Update Subscriptions</button>
      </div>
    );
  }

});

module.exports = SubscriptionList;
