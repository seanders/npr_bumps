# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    spotify_id "MyString"
    name "MyString"
    image_url "MyString"
    token "MyString"
    refresh_token "MyString"
    expires_at "MyString"
    expires_in "MyString"
  end
end
