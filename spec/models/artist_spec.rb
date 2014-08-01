# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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
