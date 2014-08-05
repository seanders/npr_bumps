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

class Program < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  validates :url, uniqueness: true
  validates :npr_id, presence: true, uniqueness: true

  has_many :episodes

  BASE_URL = "http://www.npr.org"

  def base_url
    Program::BASE_URL
  end

  def sync_tracks(date_range = DateTime.now)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014
    #Build array of episodes to sync
    episodes = sync_episodes(date_range)
    # Guard clause if there is no episode data.
    return false unless episodes

    # Concurrently request each page; Need some EM magic here
    response_array = HTMLGetter.async_page_request(episodes)

    response_array.each do |hash|
      episode, http_response = hash[:html_object], hash[:response]
      # Update episode data
      episode.update_date_from_html(http_response)
      episode.sync_tracks(http_response)
    end
  end

  def sync_episodes(date_range)
    raw_response = Npr::Api.new.get_episodes(id: npr_id, date: date_range)
    # If there are no stories for this day, simply return false.
    return false if raw_response.empty?
    episode_ids_with_urls = Npr::Parser.new(raw_response).parse_episode_ids_and_urls
    create_episodes_from_npr_ids(episode_ids_with_urls)
  end

  def create_episodes_from_npr_ids(episode_ids_with_urls)
    episode_ids_with_urls.map do |hash|
      Episode.create_with(program: self, url: hash[:url]).find_or_create_by(npr_id: hash[:id])
    end
  end
end
