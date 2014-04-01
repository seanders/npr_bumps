class Show < ActiveRecord::Base
  belongs_to :program
  has_many :show_tracks
  has_many :tracks, through: :show_tracks
end
