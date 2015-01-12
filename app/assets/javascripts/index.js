$(function () {
  var PlaylistContainer = require('./components/PlaylistContainer.js.jsx')
      React = require('react'),
      injectTapEventPlugin = require("react-tap-event-plugin"),
      reactTarget = $('#playlist-target')[0];

  //Needed for onTouchTap
  //Can go away when react 1.0 release
  //Check this repo:
  //https://github.com/zilverline/react-tap-event-plugin

  injectTapEventPlugin();

  if (reactTarget) {
    React.render(
      <PlaylistContainer/>,
      reactTarget
    );
  }
});
