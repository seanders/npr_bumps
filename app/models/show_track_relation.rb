class ShowTrackRelation < ActiveRecord::Base
  belongs_to :show
  belongs_to :track
  validates_uniqueness_of :show_id, scope: :track_id
  validates :show_id, presence: true
  validates :track_id, presence: true
end
