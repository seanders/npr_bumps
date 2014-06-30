require 'spec_helper'

describe Program do
  before(:each) do
    @program = Program.new()
    @program.stub(:slug) { "all-things-considered" }
  end

  describe "validations" do
    it "should require a name attribute" do
      @program.save
      @program.errors.count.should eq(1)
    end

    it "should validate uniqueness of the name attribute" do
      create(:program, name: "lol")
      @program.name = "lol"
      @program.save
      @program.errors.count.should eq(1)
    end

    it "should validate uniqueness of the url attribute" do
      create(:program, url: "noob")
      @program.url = "noob"
      @program.name = "don'tmatter"
      @program.save
      @program.errors.count.should eq(1)
    end

  end

  describe ".base_url" do
    it "should return the BASE_URL constant for the class" do
      @program.base_url.should eq("http://www.npr.org")
    end
  end

  describe ".build_html_request_objects" do
    it "should return an array of html request objects" do
      html_objects = @program.build_html_request_objects(DateRange.new("1-10-2014", "3-13-2014"))
      html_objects.length.should eq(3)
      html_objects.first.should be_a(HTMLGetter)
    end
  end

  describe ".parse_attributes_from_html" do
    it "should parse attributes from html responses" do
      html_array = [
        '<article class="program-archive-episode" data-episode-id="269516522" data-episode-date="2014-01-31"></article>',
        '<article class="program-archive-episode" data-episode-id="268906743" data-episode-date="2014-01-30"></article>'
      ]
      @program.parse_attributes_from_html(html_array).should eq(
        [
          { remote_id: 269516522, date: "2014-01-31" },
          { remote_id: 268906743, date: "2014-01-30" }
        ]
      )
    end
  end
end
