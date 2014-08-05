class Npr::Api
  class NoDataError < StandardError; end
  attr_accessor :response

  PER_PAGE = 50

  def initialize(args = nil)
    # Initialize NPR client at  a later time-0
    @response = []
  end

  def episode_fields
    %w(parent storyDate).join(",")
  end

  def get_episodes(options = {})
    options[:date] = parse_date(options[:date])
    api_response = query(options.merge({fields: episode_fields}))
    @response += api_response.list.stories if api_response.messages.first.try(:id) != StatusCodes::NO_RESULTS
    # If the API returns fewer results than the per_page, we know we have exhausted all possible responses
    return @response if api_response.list.stories.count < PER_PAGE
    # Poll the API until we have received all responses. There doesn't seem to be rate limiting.
    get_episodes(options.merge(startNum: @response.count))
  end

  def query(options = {})
    NPR::Story.where(options).limit(PER_PAGE).query
    # raise NoDataError, "No results for this query:\n#{options}" if response.messages.first.try(:id) == StatusCodes::NO_RESULTS
    # response
  end

  private

  module StatusCodes
    NO_RESULTS = "401"
  end

  def parse_date(date_range)
    return date_range if date_range.is_a?(Range)
    date_range.strftime('%Y-%m-%d')
  end
end
