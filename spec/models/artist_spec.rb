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

  describe '#self.find_or_create_from_name' do
    it 'should find or create an artist if given a name attribute' do
      attrs = {name: "Xzibit"}
      allow(Artist).to receive(:find_or_create_by) { build_stubbed(:artist, name: attrs[:name]) }
      expect(Artist.find_or_create_from_name(attrs).name).to eq(attrs[:name])
    end

    it 'should return nil if artist name does not exist' do
      attrs = {name: nil}
      expect(Artist.find_or_create_from_name(attrs)).to be nil
    end
  end
end
