class Program < ActiveRecord::Base
  has_many :shows

  BASE_URL = "http://www.npr.org/programs"

  def remote_sync_shows_between(date_range)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # E.G.: "?date=2-28-2014"

    # Build array of last days of each month in date range
    index_months_array = build_index_months(date_range)

    # Concurrently request each page; Need some EM magic here

    # Scrape the page and parse out date + remote_id pairs for each show

    # Create shows with date and remote_id

    # query recently created shows in that date range

    # for each show, request that show page, scrape the track and create the show_track_relation
  end

  def foo
    HTMLGetter.new(self)
  end

  def base_url
    Program::BASE_URL
  end

end
