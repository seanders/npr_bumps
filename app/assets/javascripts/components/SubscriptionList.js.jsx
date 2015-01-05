var React = require('react');
var SubscriptionItem = require('./SubscriptionItem.js.jsx')

var SubscriptionList = React.createClass({
  render: function() {
    debugger;
    var subscriptionItems = this.props.items.map(function (subscription) {
      return (
        <SubscriptionItem name={subscription.name} key={subscription.id} subscribed={subscription.subscribed} />
      )
    });
    return (
      <div>
        {subscriptionItems}
      </div>
    );
  }

});

module.exports = SubscriptionList;
