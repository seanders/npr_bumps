class Program < ActiveRecord::Base
  has_many :shows

  BASE_URL = "http://www.npr.org"

  def base_url
    Program::BASE_URL
  end

  def remote_sync_shows_between(date_range)
    # Note: NPR archive pages use the last date of each month to load the episodes for an entire month
    # http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014

    # Build array of last days of each month in date range
    html_objects = build_html_objects(date_range)

    # Build array of urls to request on

    # Concurrently request each page; Need some EM magic here
    async_page_request(html_objects)

    # Scrape the page and parse out date + remote_id pairs for each show

    # Create shows with date and remote_id

    # query recently created shows in that date ranges

    # for each show, request that show page, scrape the track and create the show_track_relation
  end

  def build_html_objects(date_range)
    index_month_dates = build_archive_months(date_range)
    index_month_dates.map do |date|
      html_getter = HTMLGetter.new(self, "/archive", date)
    end
  end

  def build_archive_months(date_range)
    months_in_between = date_range.months_in_between
    month_index = (0..months_in_between)
    month_index.map do |advance|
      index_date = date_range.start_date.advance(months: advance).end_of_month
    end
  end

  def async_page_request(html_objects=[])
    pages = []
    EM.run {
      EM::Iterator.new(html_objects, 10).each(
        proc { |html_object, iterator|
          connection = EventMachine::HttpRequest.new(html_object.base_url)
          http = connection.get(path: html_object.build_path('/archive'), query: html_object.build_parameters({date: html_object.date }))
          p http
          http.callback { |http|
            pages << http.response
            iterator.next
          }
        },
        proc { EM.stop }
      )
    }
    pages
  end

end
