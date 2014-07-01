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
  has_many :episodes
  validates :name, uniqueness: true, presence: true
  validates :url, uniqueness: true

  BASE_URL = "http://www.npr.org"

  def base_url
    Program::BASE_URL
  end

  def remote_sync_songs(date_range)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014
    #Build array of episodes to sync
    episodes = sync_episodes(date_range)

    # Concurrently request each page; Need some EM magic here
    response_array = HTMLGetter.async_page_request(episodes)

    response_array.each do |hash|
      episode, http_response = hash[:html_object], hash[:response]
      # Update episode data
      episode.update_date_from_html(http_response)
      episode.sync_songs(http_response)
    end

    # # Create shows with date and remote_id; NB: Overinclude will add shows potentially outside the specific date-range
    # shows = Show.find_or_create_from_attributes(show_attributes, self)
    # # for each show in date range, request that show page, scrape the track and create the show_track_relation
    # shows_needing_sync = Show.where(date: date_range.start_date..date_range.end_date)

    # Show.batch_remote_sync(shows_needing_sync)

  end

  def sync_episodes(date_range)
    raw_response = Npr::Api.new.get_episodes(id: npr_id, date: date_range)
    episode_ids_with_urls = Npr::Parser.new(raw_response).parse_episode_ids_and_urls
    create_episodes_from_npr_ids(episode_ids_with_urls)
  end

  def create_episodes_from_npr_ids(episode_ids_with_urls)
    episode_ids_with_urls.map do |hash|
      Episode.create_with(program: self, url: hash[:url]).find_or_create_by(npr_id: hash[:id])
    end
  end
end
