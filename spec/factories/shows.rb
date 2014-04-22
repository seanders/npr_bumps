FactoryGirl.define do
  factory :show do
    sequence(:date) { |n| (Date.new(2000,12,31) + n.days) }
    sequence(:remote_id) { |n| n }
    association :program, factory: :program
  end
end
