require 'spec_helper'

describe ShowTrackRelation do
  describe "validations" do
    it "should not allow more than one relation between a show and a track" do
      show_track_relation = ShowTrackRelation.create(show_id: 1, track_id: 1)
      new_str = ShowTrackRelation.new(show_id: 1, track_id: 1)
      new_str.save.should eq(false)
    end

    it "should require a show_id" do
      new_str = ShowTrackRelation.new(track_id: 1)
      new_str.save.should eq(false)
    end

    it "should require a tracker_id" do
      new_str = ShowTrackRelation.new(show_id: 1)
      new_str.save.should eq(false)
    end
  end
end
