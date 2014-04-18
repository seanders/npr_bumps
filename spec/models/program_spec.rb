require 'spec_helper'

describe Program do
  before(:each) do
    @program = Program.new()
    @program.stub(:slug) { "all-things-considered" }
  end

  describe ".base_url" do
    it "should return the BASE_URL constant for the class" do
      @program.base_url.should eq("http://www.npr.org/programs")
    end
  end

  describe ".build_html_objects" do
    it "should return an array of index urls" do
      html_objects = @program.build_html_objects(DateRange.new("1-10-2014", "3-13-2014"))
      html_objects.length.should eq(3)
    end
  end

  describe ".build_archive_months" do
    it "should build an array of the last days of the month for months in the date range" do
      range = DateRange.new("1-10-2014", "3-13-2014")
      @program.build_archive_months(range).should eq(
        [
          Time.new(2014, 1, 31).end_of_month,
          Time.new(2014, 2, 28).end_of_month,
          Time.new(2014, 3, 31).end_of_month
        ]
      )
    end
  end
end
