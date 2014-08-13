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

  has_many :tracks
  has_many :albums

  def self.find_or_create_from_name(attrs)
    Artist.where(attrs).first_or_create
  end
end
