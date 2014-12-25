$(function () {
  var PlaylistContainer = require('./components/PlaylistContainer.js.jsx')
  var React = require('react');
  var reactTarget = $('#playlist-target')[0]
  if (reactTarget) {
    React.render(
      <PlaylistContainer/>,
      reactTarget
    );    
  }
});
