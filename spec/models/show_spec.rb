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
end
