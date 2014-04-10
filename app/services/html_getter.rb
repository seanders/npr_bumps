class HTMLGetter

  def initialize(program)
    @base_url = program.class::BASE_URL
    @program_slug = program.slug
    # @options = { query: options[:query] }
  end

  def build_path(path)
    @base_url + "/" + @program_slug + path
  end

  def build_parameters(params)
    built_params = {}
    if params.has_key?(:date)
      date = params[:date]
      built_params[:date] = parameterize_month(date[:month], date[:year])
    end
    final_params = { query: built_params }
  end

  def parameterize_month(month, year)
    time = Time.new(year, month)
    date_parameter = time.end_of_month.strftime("%m-%d-%Y")
  end

  def get_html(path, options={})
    url_path = build_path(path)
    options = build_parameters(options)
    log_request(url_path, options)
    HTTParty.get(build_path(path), options)
  end

  def log_request(url, options)
    Rails.logger.info("Requesting data from NPR:")
    Rails.logger.info("PATH: #{url}")
    Rails.logger.info("PARAMS: #{options}")
  end
end
