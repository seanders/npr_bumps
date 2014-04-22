class HTMLGetter
  attr_reader :base_url, :program_slug, :path, :parameters

  def initialize(program, path, parameters={})
    @base_url = program.base_url
    @path = path
    @parameters = parameters
    @program_slug = program.slug
  end

  def build_path(path=nil)
    #reference: http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014
    # http://www.npr.org/programs/all-things-considered/2014/01/31/269516522?showDate=2014-01-31
    "/programs/" + @program_slug + @path
  end

  def build_parameters
    built_params = {}
    built_params[:date] = parameterize_month(@parameters[:date]) if @parameters.has_key?(:date)
    built_params[:view] = @parameters[:view] if @parameters.has_key?(:view)
    built_params
  end

  def build_url(path)
    @base_url + "/" + @program_slug + path
  end

  def parameterize_month(time_object)
    date_parameter = time_object.end_of_month.strftime("%-m-%d-%Y")
  end

  def self.async_page_request(html_objects=[])
    pages = []
    EM.run {
      EM::Iterator.new(html_objects, 10).each(
        proc { |html_object, iterator|
          p connection = EventMachine::HttpRequest.new(html_object.base_url)
          p http = connection.get(path: html_object.build_path, query: html_object.build_parameters)
          http.callback { |http|
            pages << http.response
            iterator.next
          }
        },
        proc { EM.stop }
      )
    }
   p pages
  end

  def get_html(path, options={})
    url_path = build_url(path)
    options = build_parameters(options)
    log_request(url_path, options)
    HTTParty.get(url_path, query: options)
  end

  def log_request(url=nil, options=nil)
    Rails.logger.info("Requesting data from NPR:")
    Rails.logger.info("PATH: #{url}")
    Rails.logger.info("PARAMS: #{options}")
  end
end
