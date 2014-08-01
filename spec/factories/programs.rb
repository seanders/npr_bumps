# == Schema Information
#
# Table name: programs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :string(255)
#  slug       :string(255)
#  npr_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :program do
    sequence(:name) { |n| "program_#{n}" }
    url "http://www.fake_url.com"
    sequence(:slug) { |n| "program-one-#{n}" }
  end
end
