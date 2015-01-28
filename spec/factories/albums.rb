# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  artist_id  :integer
#  spotify_id :string(255)
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    sequence(:name) {|n| "album-#{n}"}
    artist
    sequence(:spotify_id)
    sequence(:image_url) {|n| "http://www.fake-image.com/#{n}"}
  end
end
