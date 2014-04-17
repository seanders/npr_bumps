require 'spec_helper'

describe DateRange do

  before(:each) do
    @date_range = DateRange.new("1-10-2014", "3-13-2014")
  end

  describe "#initialize" do
    it "should initilize with start and end date attributes as Time objects" do
      expect(@date_range.start_date).to be_an_instance_of(Time)
      expect(@date_range.end_date).to be_an_instance_of(Time)
    end

    it "should properly parse the start_time" do
      @date_range.start_date.to_s.should eq("2014-01-10 00:00:00 -0800")
    end

    it "should properly parse the end_time" do
      @date_range.end_date.to_s.should eq("2014-03-13 00:00:00 -0700")
    end
  end

  describe "#months_in_between" do
    it "should return an array of month integers in the date range" do
      @date_range.months_in_between.should eq(2)
    end
  end
end
