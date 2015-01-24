# == Schema Information
#
# Table name: playlists
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  external_id       :integer
#  person_id         :integer
#  external_owner_id :integer
#  public            :boolean
#  collaborative     :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Playlist do
  let(:playlist) { create(:playlist) }
  let(:program) { create(:program) }

  describe '#update_subscriptions' do
    it "should return true if the playlist updated successfully" do
      expect(playlist.update_subscriptions(program.id)).to be_true
    end
  end
end
