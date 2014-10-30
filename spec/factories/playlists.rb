# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlist do
    name "MyString"
    external_id 1
    user_id 1
    external_owner_id 1
    public false
    collaborative false
  end
end
