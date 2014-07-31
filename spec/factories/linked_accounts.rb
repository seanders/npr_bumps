# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :linked_account do
    uid 1
    image_url "MyString"
    oauth_token "MyString"
    refresh_token "MyString"
    expires_at "MyString"
    expires_in 1
  end
end
