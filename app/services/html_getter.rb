class HTMLGetter
  attr_reader :base_url, :program_slug, :path, :date

  def initialize(program, path, date)
    @base_url = program.base_url
    @program_slug = program.slug
    @date = date
  end

  def build_path(path)
    #reference: http://www.npr.org/programs/all-things-considered/archive?date=3-31-2014
    # http://www.npr.org/programs/all-things-considered/2014/01/31/269516522?showDate=2014-01-31
    # http://www.npr.org/programs/morning-edition/?view=musicview
    "/programs/" + @program_slug + path
  end

  def build_parameters(params={})
    built_params = {}
    built_params[:date] = parameterize_month(params[:date]) if params.has_key?(:date)
    built_params[:view] = params[:view] if params.has_key?(:view)
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
