class Track < ActiveRecord::Base
  belongs_to :artist
  has_many :show_track_relations
  has_many :shows, through: :show_track_relations
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :artist_id
end
