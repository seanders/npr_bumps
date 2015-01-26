# == Schema Information
#
# Table name: linked_accounts
#
#  id            :integer          not null, primary key
#  uid           :integer
#  person_id     :integer
#  type          :string(255)
#  email         :string(255)
#  name          :string(255)
#  image_url     :string(255)
#  oauth_token   :string(255)
#  refresh_token :string(255)
#  expires_at    :string(255)
#  expires_in    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:oauth_token) {|n| "oauth-token-#{n}"}

  factory :linked_account do
    uid 1
    image_url "MyString"
    oauth_token
    refresh_token "MyString"
    expires_at "MyString"
    expires_in 1
  end

  factory :spotify_account, class: LinkedAccount::Spotify do
    sequence(:uid) {|n| n}
    person
    image_url "MyString"
    oauth_token
    refresh_token "MyString"
    expires_at 2.hours.from_now

    factory :spotify_account_with_expired_token do
      expires_at 2.hours.ago  
    end
  end
end
