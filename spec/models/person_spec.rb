# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Person do
  let(:person) { create(:person) } 

  let(:existing_playlist_attrs) do
    playlist = create(:playlist, person: person)
    {
      'name' => playlist.name,
      'id' => playlist.external_id.to_s,
      'owner' => playlist.external_owner_id.to_s,
      'public' => playlist.public,
      'collaborative' => playlist.collaborative
    }
  end

  let(:new_playlist_attrs) do
    {
      'name' => "Dat Playlist",
      'id' => 1234,
      'owner' => {'id' => 31},
      'public' => true,
      'collaborative' => true
    }  
  end

  describe '#batch_create_or_update_playlists' do
    it "should create a new playlist for the person if it does not exist" do
      person.batch_create_or_update_playlists([new_playlist_attrs])
      expect(person.playlists.length).to eq(1)
    end

    it 'should update an existing playlist' do
      person.batch_create_or_update_playlists([existing_playlist_attrs])
      expect(person.playlists.length).to eq(1)
    end
  end
end
