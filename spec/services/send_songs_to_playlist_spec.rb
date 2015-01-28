require 'spec_helper'

describe SendSongsToPlaylists do
  let(:service) { described_class.new(person) }
  let(:person) { create(:person) }
  let(:program) { create(:program_with_episodes) }
  let(:playlist) { create(:playlist, person: person) }
  let!(:playlist_program_relation) { create(:playlist_program_relation, playlist: playlist, program: program) }

  it "should return an array of songs to send to the users playlist" do
    song_result = service.get_songs_for_playlist(playlist)
    binding.pry
  end
end
