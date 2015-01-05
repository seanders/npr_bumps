// Deps
var React = require('react');

var PlaylistItem = React.createClass({
  render: function() {
    return (
      <div className="playlist-item">
        <a href="javascript:;"
           className="playlist-name"
           onClick={this.showSubscriptions}
           >{this.props.name}
        </a>
      </div>
    );
  },
  showSubscriptions: function () {
    // call passed in function from parent with playlistId as argument
    this.props.getSubscriptions(this.props.playlistId);
  }
});

module.exports = PlaylistItem;
