# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Artist < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :tracks, through: :track_artist_relations
  has_many :track_artist_relations
  has_many :albums

  def self.batch_find_or_create(attribute_array)
    attribute_array.map {|attrs| find_or_create_from_name(attrs) }
  end

  def self.find_or_create_from_name(attrs)
    name = attrs.fetch(:name, nil)
    return nil if name.nil?
    Artist.find_or_create_by(name: name)
  end
end
