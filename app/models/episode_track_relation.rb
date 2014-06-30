# == Schema Information
#
# Table name: show_track_relations
#
#  id         :integer          not null, primary key
#  show_id    :integer
#  track_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class EpisodeTrackRelation < ActiveRecord::Base
  belongs_to :episode
  belongs_to :track
  validates_uniqueness_of :episode_id, scope: :track_id
  validates :episode_id, presence: true
  validates :track_id, presence: true
end
