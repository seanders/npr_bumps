require 'spec_helper'

describe SpotifyTrackSyncer do
  let(:track_syncer) { SpotifyTrackSyncer.instance }
  let(:track) { track = double(artist: double(name: "foo"), album: double(name: 'bar'), title: 'song title') }
  describe '#sync_track' do
    it 'should update the spotify_id and external_id attributes on a track' do
      allow(track_syncer).to receive(:spotify_client) {double(search: true)}
      allow(track_syncer).to receive(:parse_external_ids_from_api_response) {{spotify_id: 1, external_ids: {foo: 'bar'}}}
      expect(track).to receive(:update_attributes).with(track_syncer.parse_external_ids_from_api_response)
      track_syncer.sync_track(track)
    end
  end

  describe '#build_track_search_params' do
    it 'should return a correctly formatted search string for the Spotify search api' do
      expect(track_syncer.send(:build_track_search_params, track)).
      to eq("track:'song title' artist:'foo' album:'bar'")
    end
  end

  describe '#parse_external_ids_from_api_response', :requires => :spotify_mock_response do
    it 'should return a hash of spotify_id and external_ids' do
      spotify_id_and_external_ids = track_syncer.parse_external_ids_from_api_response(mock_search_response)
      expect(spotify_id_and_external_ids[:spotify_id]).to eq('7r87p4bnlP642xfobiCZlj')
      expect(spotify_id_and_external_ids[:external_ids]).to eq({"isrc"=>"USAT21401105"})
    end
  end

  describe '#spotify_client' do
    it 'should return an instance of the spotify_client' do
      expect(track_syncer.spotify_client).to be_a(Spotify::Client)
    end
  end
end
