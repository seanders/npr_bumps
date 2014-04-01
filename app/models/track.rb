class Track < ActiveRecord::Base
  belongs_to :artist
  has_many :show_tracks
  has_many :shows, through: :show_tracks
end
