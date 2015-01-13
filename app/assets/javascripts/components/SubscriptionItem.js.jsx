var React = require('react'),
    mui = require('material-ui'),
    Toggle = mui.Toggle;

var SubscriptionItem = React.createClass({
  clickHandler: function (event, toggledState) {
    var playlistId = this.props.programId;
    var subscribed = toggledState;
    this.props.onChangeHandler(playlistId, toggledState);
  },

  render: function() {
    return (
      <div className="subscription-item">
        <div className="subscription-item--toggle">
          <Toggle toggled={this.props.subscribed} onToggle={this.clickHandler}/>
        </div>
        <h5 className="subscription-item--label">{this.props.name}</h5>
      </div>
    )
  }

});

module.exports = SubscriptionItem;
