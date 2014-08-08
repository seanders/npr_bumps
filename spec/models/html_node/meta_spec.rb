require 'spec_helper'

describe HtmlNode::Meta do
  before(:each) do
    musicwrap_meta = Nokogiri::HTML(open(Rails.root + "spec/mock_html/music_wrap_meta.html"))
    @meta = HtmlNode::Meta.new(musicwrap_meta)
  end

  describe '#build_track_attributes' do
    it 'should return a hash with the track title' do
      expect(@meta.build_track_attributes[:track_title]).to eq('Ballad of Sparrow Young')
    end

    it 'should return a hash with the artist name' do
      expect(@meta.build_track_attributes[:artist_name]).to eq('The Gentleman Losers')
    end

    it 'should return a hash with the album name' do
      expect(@meta.build_track_attributes[:album_name]).to eq('Dustland')
    end

    it 'should return a hash with the label name' do
      expect(@meta.build_track_attributes[:label_name]).to eq('MadeUp')
    end
  end
end
