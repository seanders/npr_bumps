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
    sequence(:name) { |n| "person_name_#{n}"}
    sequence(:email) { |n| "email-#{n}@example.com" }
  end
end
