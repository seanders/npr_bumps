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
  factory :program, aliases: [:subscription] do
    sequence(:name) { |n| "program_#{n}" }
    sequence(:url) { |n| "http://www.fake_url-#{n}.com" }
    sequence(:slug) { |n| "program-one-#{n}" }
    sequence(:npr_id)

    factory :program_with_episodes do
      ignore do
        episodes_count 3
      end

      after(:create) do |program, evaluator|
        create_list(:episode_with_tracks, evaluator.episodes_count, program: program)
      end
    end
  end
end
