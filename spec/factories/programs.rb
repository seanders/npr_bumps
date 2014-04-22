FactoryGirl.define do
  factory :program do
    sequence(:name) { |n| "program_#{n}" }
    url "http://www.fake_url.com"
    sequence(:slug) { |n| "program-one-#{n}" }
  end
end
