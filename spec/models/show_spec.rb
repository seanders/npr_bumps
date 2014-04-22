require "spec_helper"

describe Show do

  before(:each) do
    @stub_program = double("Program")
    @stub_program.stub(:id) { 3 }
  end

  describe "#find_or_create_from_attributes" do
    it "should create new show objects if it doesn't already exist" do
      expect {
        shows = Show.find_or_create_from_attributes([{remote_id: 123, date: "2014-1-31"}], @stub_program)
      }.to change(Show, :count).by 1
    end

    it "should find existing show objects" do
      Show.create(remote_id: 456, program_id: 3)
      expect {
        shows = Show.find_or_create_from_attributes(
          [
            {remote_id: 123, date: "2014-1-31"},
            {remote_id: 456, date: "2014-1-30"}
          ],
          @stub_program
        )
      }.to change(Show, :count).by 1
    end
  end

  describe "#build_html_request_object" do
    it "should return an HTMLGetter object" do
      show = create(:show)
      html_obj = show.build_html_request_object
      html_obj.should be_a(HTMLGetter)
    end
  end

  describe "#parse_raw_html" do
    it "should return an array of song-attribute maps" do
      raw_html = File.open("/Users/sean/Desktop/npr_bumps/spec/mock_html/mock_show.html", "r").read
      parsed = Show.parse_raw_html(raw_html)
      parsed.should eq(
        [
          { :track_title=>"Ballad of Sparrow Young", :artist_name=>" The Gentleman Losers" },
          { :track_title=>"Street Beat", :artist_name=>" DJ Revolution" }
        ]
      )
    end
  end

  describe "#batch_remote_sync" do
    it "should method_name" do

    end
  end
end
