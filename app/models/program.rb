class Program < ActiveRecord::Base
  has_many :shows

  BASE_URL = "http://www.npr.org"

  def base_url
    Program::BASE_URL
  end

  def remote_sync_shows_between(date_range)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014

    # Build array of html_objects for query
    html_objects = build_html_request_objects(date_range)

    # Concurrently request each page; Need some EM magic here
    html_pages = HTMLGetter.async_page_request(html_objects)

    # parse html_pages for remote_ids of specific shows
    show_attributes = parse_attributes_from_html(html_pages)

    # Create shows with date and remote_id; NB: Overinclude will add shows potentially outside the specific date-range
    shows = Show.find_or_create_from_attributes(show_attributes, self)
    # for each show in date range, request that show page, scrape the track and create the show_track_relation
    shows_needing_sync = Show.where(date: date_range.start_date..date_range.end_date)

    Show.batch_remote_sync(shows_needing_sync)

  end

  def build_html_request_objects(date_range)
    index_month_dates = build_archive_months(date_range)
    index_month_dates.map do |date|
      html_getter = HTMLGetter.new(self, "/archive", {date: date})
    end
  end

  def build_archive_months(date_range)
    months_in_between = date_range.months_in_between
    month_index = (0..months_in_between)
    month_index.map do |advance|
      index_date = date_range.start_date.advance(months: advance).end_of_month
    end
  end

  # parse each page and create an array of maps containing remote_id and date of the show
  def parse_attributes_from_html(html=[])
    nested_ids = html.map do |html_string|
      Nokogiri::HTML(html_string).css(".program-archive-episode").map do |episode_tag|
        {
          remote_id: episode_tag.attribute("data-episode-id").value.to_i,
          date:      episode_tag.attribute("data-episode-date").value
        }
      end
    end
    nested_ids.flatten
  end

end
