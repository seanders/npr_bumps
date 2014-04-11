require 'spec_helper'

describe HTMLGetter do

  before(:each) do
    @program = double("Program")
    @program.stub(:base_url) { "base_url" }
    @program.stub(:slug) { "slug" }
    @html_getter = HTMLGetter.new(@program)
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
    it "should return a complete url with base_url + slug + path" do
      @html_getter.build_path('/archive').should eq("base_url/slug/archive")
    end
  end

  describe "#build_parameters" do
    it "should return a hash with a query key" do
      @html_getter.stub(:parameterize_month).and_return("date")
      params = @html_getter.build_parameters(date: { month: 1, year: 2014 })
      params.should eq({query: { date: "date" }})
    end

    it "should return an empty hash if called with no parameters" do
      @html_getter.build_parameters().should eq({:query=>{}})
    end
  end

  describe "#parameterize_month" do
    it "should return a string-ified datetime object in m-d-Y format for the last day of the month" do
      @html_getter.parameterize_month(1, 2014).should eq("1-31-2014")
    end
  end

  describe "#get_html" do
    it "should build the path and parameters, log the request, and fire the get request" do
      @html_getter.should_receive(:build_path).and_call_original
      @html_getter.should_receive(:build_parameters).and_call_original
      HTTParty.should_receive(:get).with("base_url/slug/archive", {:query=>{}})
      @html_getter.get_html("/archive")
    end
  end
end

