require 'spec_helper'

describe HTMLGetter do

  before(:each) do
    @program = double("Program")
    @program.stub(:base_url) { "base_url" }
    @program.stub(:slug) { "slug" }
    @program.stub(:date) { Time.new(2014, 1, 13) }
    @html_getter = HTMLGetter.new(@program, "/archive", {date: Time.new(2014, 1, 13)})
  end

  describe "#intialize" do
    it "should initialize with a base_url" do
      @html_getter.base_url.should eq("base_url")
    end

    it "should intialize with slug" do
      @html_getter.program_slug.should eq("slug")
    end
  end

  describe "#build_path" do
    context "with an argument" do
      it "should return a complete url with base_url + slug + path" do
        @html_getter.build_path('/archive').should eq("/programs/slug/archive")
      end
    end

    context "without an argument" do
      it "should return a complete url using the objects path attribute" do
        @html_getter.build_path.should eq("/programs/slug/archive")
      end
    end
  end

  describe "#build_parameters" do
    it "should return a hash with a query key" do
      @html_getter.stub(:parameterize_month).and_return("date")
      params = @html_getter.build_parameters
      params.should eq({ date: "date" })
    end

    it "should return an empty hash if called with no parameters" do
      @no_params_html_getter = HTMLGetter.new(@program, "/archive")
      @no_params_html_getter.build_parameters.should eq({})
    end
  end

  describe "#parameterize_month" do
    it "should return a string-ified datetime object in m-d-Y format for the last day of the month" do
      @html_getter.parameterize_month(Time.new(2014, 1)).should eq("1-31-2014")
    end
  end

  # describe "#get_html" do
  #   it "should build the path and parameters, log the request, and fire the get request" do
  #     HTTParty.should_receive(:get).with("base_url/slug/archive", query: {})
  #     @html_getter.get_html("/archive")
  #   end
  # end
end

