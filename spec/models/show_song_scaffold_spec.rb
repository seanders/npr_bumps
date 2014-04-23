require 'spec_helper'

describe ShowSongScaffold do

  before(:each) do
    @raw_html = File.open("/Users/sean/Desktop/npr_bumps/spec/mock_html/mock_show.html", "r").read
    @show = create(:show)
    @scaffold = ShowSongScaffold.new(@show, @raw_html)
  end

  describe "#initialize" do

    it "should create a ShowSongScaffold wiht a show attribute" do
      @scaffold.show.should eq(@show)
    end

    it "should create a ShowSongScaffold with a raw_html attribute" do
      @scaffold.raw_html.should eq(@raw_html)
    end

    it "should create a SongShowScaffold with a song_attributes_array" do
      # no need to test the parse method here. already testing in song
      @scaffold.song_attributes_array
    end
  end

  describe "#create_tracks_from_attributes" do

    it "should create new tracks from its song_attributes_array" do
      expect {
        @scaffold.create_tracks_from_attributes
      }.to change(Track, :count).by 2
    end

    it "should create new Artists from its song_attributes_array" do
      expect {
        @scaffold.create_tracks_from_attributes
      }.to change(Artist, :count).by 2
    end

    it "should create new ShowTrackRelations" do
      expect {
        @scaffold.create_tracks_from_attributes
      }.to change(ShowTrackRelation, :count).by 2
    end
  end

end
