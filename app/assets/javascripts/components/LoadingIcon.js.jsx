var React = require('react'),
    mui = require('material-ui'),
    Icon = mui.Icon;

var LoadingIcon = React.createClass({

  render: function() {
    return (
      <div className="subscription-index--loading-icon">
        <div className="loading-spinner">
          <div className="icon-container">
            <Icon className="center-icon" icon="action-backup" />
          </div>
        </div>
      </div>
    );
  }

});

module.exports = LoadingIcon;
