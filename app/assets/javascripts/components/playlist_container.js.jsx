$(function () {
  var PlaylistContainer = React.createClass({
    render: function () {
      return (
        <div>
          <PlaylistIndex></PlaylistIndex>
        </div>
      )
    }
  });

var PlaylistIndex = React.createClass({

  getInitialState: function () {
    return {
      playlists: $('#playlist-panel').data('playlists')
    }
  },

  render: function() {
    var playlistItems = this.state.playlists.map(function (playlistItem) {
      return (
        <PlaylistItem name={playlistItem.name} />
      )
    })
    return (
      <div>
        {playlistItems}
      </div>
    );
  }

});

var PlaylistItem = React.createClass({
  render: function() {
    return (
      <div className="playlist-item">
        <a href="javascript:;" className="playlist-name">{this.props.name}</a>
      </div>
    );
  }
});

  var reactTarget = $('#playlist-target')[0]
  if (reactTarget)
  React.render(
    <PlaylistContainer/>,
    reactTarget
  );
});
