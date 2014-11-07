# == Schema Information
#
# Table name: album_artist_relations
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album_artist_relation do
  end
end
