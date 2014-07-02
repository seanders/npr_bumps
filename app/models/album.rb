# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  artist_id  :integer          not null
#  label      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: :artist}
  validates :artist, presence: true

  belongs_to :artist
  has_many :tracks
end
