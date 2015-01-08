var React = require('react');

var SubscriptionItem = React.createClass({
  clickHandler: function (event) {
    debugger;
  },

  render: function() {
    return (
      <div>
        <label for={this.props.programId}>
          <input id={this.props.programId} type="checkbox" value={this.props.programId} checked={this.props.subscribed} onChange={this.clickHandler}/> 
          {this.props.name}
        </label>
      </div>
    )
  }

});

module.exports = SubscriptionItem;
