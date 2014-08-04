require 'spec_helper'


describe SpotifyTrackSyncer do
  let(:track_syncer) { SpotifyTrackSyncer.instance }

  describe '#build_track_search_params' do
    it 'should return a correctly formatted search string for the Spotify search api' do
      track = double(artist: double(name: "foo"), album: double(name: 'bar'), name: 'song title')
      expect(track_syncer.send(:build_track_search_params, track)).
      to eq("track:'song title' artist:'foo' album:'bar'")
    end
  end

  describe '#spotify_client' do
    it 'should return an instance of the spotify_client' do
      expect(track_syncer.spotify_client).to be_a(Spotify::Client)
    end
  end
end
