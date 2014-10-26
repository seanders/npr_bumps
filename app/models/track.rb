# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  artist_id    :integer
#  album_id     :integer
#  external_ids :string(255)
#  spotify_id   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Track < ActiveRecord::Base
  serialize :external_ids
  # serialize :npr_attributes

  validates :title, presence: true
  validates_uniqueness_of :title, scope: :album_id
  validates_uniqueness_of :title, scope: :artist_id

  has_many :artists, through: :track_artist_relations
  has_many :track_artist_relations
  belongs_to :album
  has_many :episode_track_relations
  has_many :episodes, through: :episode_track_relations

end
