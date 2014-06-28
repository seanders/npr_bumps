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

class ShowTrackRelation < ActiveRecord::Base
  belongs_to :show
  belongs_to :track
  validates_uniqueness_of :show_id, scope: :track_id
  validates :show_id, presence: true
  validates :track_id, presence: true
end
