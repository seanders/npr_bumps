require 'spec_helper'

describe ShowSongScaffold do

  describe "#initialize" do
    before(:each) do
      @raw_html = File.open("/Users/sean/Desktop/npr_bumps/spec/mock_html/mock_show.html", "r").read
      @show = create(:show)
      @scaffold = ShowSongScaffold.new(@show, @raw_html)
    end

    it "should create a ShowSongScaffold wiht a show attribute" do
      @scaffold.show.should eq(@show)
    end

    it "should create a ShowSongScaffold with a raw_html attribute" do
      @scaffold.raw_html.should eq(@raw_html)
    end
  end

end
