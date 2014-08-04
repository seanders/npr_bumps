# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  artist_id   :integer
#  album_id    :integer
#  external_id :string(255)
#  spotify_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Track do
  describe "validations" do
    it "should require a title" do
      new_track = Track.new()
      new_track.valid?.should eq(false)
    end

    it "should not allow duplicate track names" do
      first_track = Track.create(title: "yay")
      second_track = Track.new(title: "yay")
      second_track.valid?.should eq(false)
    end
  end
end
