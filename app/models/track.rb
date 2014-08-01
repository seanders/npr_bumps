# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  artist_id  :integer
#  album_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :album_id
  validates_uniqueness_of :title, scope: :artist_id

  belongs_to :artist
  belongs_to :album
  has_many :episode_track_relations
  has_many :episodes, through: :episode_track_relations
end
