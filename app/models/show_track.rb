class ShowTrack < ActiveRecord::Base
  belongs_to :show
  belongs_to :track
end
