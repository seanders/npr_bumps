# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  npr_id     :integer
#  date       :datetime
#  url        :string(255)
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :episode do
    sequence(:npr_id)
    sequence(:url) { |n| "http://www.doesnotmatter.com/#{n}" }
    date 1.day.ago
    program

    factory :episode_with_tracks do
      ignore do
        tracks_count 4
      end

      after(:create) do |episode, evaluator|
        create_list(:episode_track_relation, evaluator.tracks_count, episode: episode)
      end
    end
  end
end
