# == Schema Information
#
# Table name: tracks
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  artist_id      :integer
#  album_id       :integer
#  npr_attributes :hstore
#  external_ids   :string(255)
#  spotify_id     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    sequence(:title) {|n| "dat-song-#{n}"}
    sequence(:npr_attributes) { |n| {artist_name: "artist-#{n}", album_name: "album-#{n}"} }
    external_ids { {"isrc"=>"GBJSG1009504"} }
    sequence(:spotify_id)
    album
  end
end
