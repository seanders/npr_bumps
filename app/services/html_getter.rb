class HTMLGetter
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def self.async_page_request(html_objects=[])
    pages = []
    EM.run {
      EM::Iterator.new(html_objects, 10).each(
        proc { |html_object, iterator|
          connection = EventMachine::HttpRequest.new(html_object.url)
          http = connection.get
          Rails.logger.info(http)
          http.callback { |http|
            pages << {html_object: html_object, response: http.response}
            iterator.next
          }
        },
        proc { EM.stop }
      )
    }
   pages
  end

  def log_request(url=nil, options=nil)
    Rails.logger.info("Requesting data from NPR:")
    Rails.logger.info("PATH: #{url}")
    Rails.logger.info("PARAMS: #{options}")
  end
end
