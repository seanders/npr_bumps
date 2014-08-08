# == Schema Information
#
# Table name: unsynced_songs
#
#  id         :integer          not null, primary key
#  raw_html   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unsynced_song do
    raw_html "MyString"
  end
end
