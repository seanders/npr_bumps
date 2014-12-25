// Deps
var React = require('react');

var PlaylistItem = React.createClass({
  render: function() {
    return (
      <div className="playlist-item">
        <a href="javascript:;" className="playlist-name">{this.props.name}</a>
      </div>
    );
  }
});

module.exports = PlaylistItem;
