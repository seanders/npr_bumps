var React = require('react');

var SubscriptionItem = React.createClass({

  render: function() {
    return (
      <div>
        <input id={this.props.playlistId} type="checkbox" value={this.props.subscribed} /> 
        <label for={this.props.playlistId}>{this.props.name}</label>
      </div>
    )
  }

});

module.exports = SubscriptionItem;
