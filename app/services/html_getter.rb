class HTMLGetter
  attr_reader :base_url, :program_slug, :path, :date

  def initialize(program, path, date)
    @base_url = program.base_url
    @program_slug = program.slug
    @date = date
    # @options = { query: options[:query] }
  end

  def build_path(path)
    "/programs/" + @program_slug + path
  end

  def build_parameters(params={})
    built_params = {}
    if params.has_key?(:date)
      date = params[:date]
      built_params[:date] = parameterize_month(date)
    end
    built_params
  end

  def build_url(path)
    @base_url + "/" + @program_slug + path
  end

  def parameterize_month(time_object)
    date_parameter = time_object.end_of_month.strftime("%-m-%d-%Y")
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
