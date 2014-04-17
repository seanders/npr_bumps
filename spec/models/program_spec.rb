require 'spec_helper'

describe Program do
  before(:each) do
    @program = Program.new()
  end

  describe "#base_url" do
    it "should return the BASE_URL constant for the class" do
      @program.base_url.should eq("http://www.npr.org/programs")
    end
  end

  describe "#build_index_months" do
    it "should build an array of the last days of the month for months in the date range" do
      range = DateRange.new("1-10-2014", "3-13-2014")
      @program.build_index_months(range).should eq(
        [
          Time.new(2014, 1, 31).end_of_month,
          Time.new(2014, 2, 28).end_of_month,
          Time.new(2014, 3, 31).end_of_month
        ]
      )
    end
  end
end
