# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  artist_id  :integer
#  album_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  belongs_to :artist
  has_many :episode_track_relations
  has_many :episodes, through: :episode_track_relations
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :artist_id
end
