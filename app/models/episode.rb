# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  npr_id     :integer
#  date       :datetime
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Episode < ActiveRecord::Base
  # Validations
  validates :npr_id, presence: true
  validates :program_id, presence: true
  validates_uniqueness_of :npr_id, scope: :program_id

  # Relations
  belongs_to :program
  has_many :episode_track_relations
  has_many :tracks, through: :episode_track_relations

  def html_path
    "/programs/#{program.slug}/#{npr_id}"
  end
end
