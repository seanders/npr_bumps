# == Schema Information
#
# Table name: track_artist_relations
#
#  id         :integer          not null, primary key
#  track_id   :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track_artist_relation do
  end
end
