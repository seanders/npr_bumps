class Program < ActiveRecord::Base
  has_many :shows

  BASE_URL = "http://www.npr.org/programs"

  def get_episode_ids(date_range)
    #build a date range
    #get episode ID's for each
  end

end
