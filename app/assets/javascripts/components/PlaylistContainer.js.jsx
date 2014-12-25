// Deps
var PlaylistIndex = require("./PlaylistIndex.js.jsx");
var React = require('react');

// Component
var PlaylistContainer = React.createClass({
  render: function () {
    return (
      <div>
        <PlaylistIndex></PlaylistIndex>
      </div>
    )
  }
});

module.exports = PlaylistContainer;
