require 'spec_helper'

describe Artist do

  describe "validations" do
    before(:each) do
      @artist = Artist.new()
    end

    it "should require a name attribute" do
      @artist.save.should eq(false)
    end
  end
end
