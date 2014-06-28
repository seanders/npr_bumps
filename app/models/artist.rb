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
  has_many :tracks
  validates :name, presence: true
end
