class Program < ActiveRecord::Base
  has_many :shows

  BASE_URL = "http://www.npr.org/programs"

  def base_url
    Program::BASE_URL
  end

  def remote_sync_shows_between(date_range)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # E.G.: "?date=2-28-2014"

    # Build array of last days of each month in date range
    index_months_array = build_index_months(date_range)

    # Concurrently request each page; Need some EM magic here
    async_page_request(index_months_array)

    # Scrape the page and parse out date + remote_id pairs for each show

    # Create shows with date and remote_id

    # query recently created shows in that date range

    # for each show, request that show page, scrape the track and create the show_track_relation
  end

  def build_index_months(date_range)
    months_in_between = date_range.months_in_between
    month_index = (0..months_in_between)
    month_index.map do |advance|
      index_date = date_range.start_date.advance(months: advance).end_of_month
    end
  end

  def async_page_request(index_months)

  end

end
