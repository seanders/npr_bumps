# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  npr_id     :integer
#  date       :datetime
#  url        :string(255)
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Episode do

  let(:episode) { create(:episode) }
  describe '#sync_tracks' do
    it 'should create tracks from raw html' do
      raw_html = File.open(Rails.root+'spec/mock_html/music_wrap_meta.html', 'r')
      expect(episode).to receive(:create_tracks_from_attributes).once
      episode.sync_tracks(raw_html)
    end
  end

  describe '#create_tracks_from_attributes' do
    it 'should create a track object' do
      attrs = { track_title: "Foobar",  artist_name: "artist", album_name: "lol" }
      expect{
        episode.create_tracks_from_attributes(attrs)
      }.to change{Track.count}.by(1)
    end
  end
end
