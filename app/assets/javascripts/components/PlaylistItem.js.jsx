// Deps
var React = require('react');

var PlaylistItem = React.createClass({
  render: function() {
    return (
      <div className="playlist-item">
        <a href="javascript:;"
           className="playlist-name"
           onClick={this.handleClick}
           >
          <span className="mui-font-style-subhead-1">{this.props.playlistItem.name}</span>
        </a>
      </div>
    );
  },
  handleClick: function () {
    // call passed in function from parent with playlistId as argument
    this.props.clickHandler(this.props.playlistItem);
  }
});

module.exports = PlaylistItem;
