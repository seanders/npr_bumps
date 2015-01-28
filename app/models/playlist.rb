# == Schema Information
#
# Table name: playlists
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  external_id       :integer
#  person_id         :integer
#  external_owner_id :integer
#  public            :boolean
#  collaborative     :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class Playlist < ActiveRecord::Base
  belongs_to :person
  has_many :subscriptions, source: :program, through: :playlist_program_relations, dependent: :destroy
  has_many :playlist_program_relations
  validates :external_id, uniqueness: true, presence: true
  validates :external_owner_id, presence: true

  scope :subscribed, -> { includes(:subscriptions).where('playlist_program_relations.playlist_id IS NOT NULL').references(:subscriptions) } 

  def update_subscriptions(program_ids)
    update_attributes(subscription_ids: program_ids)
  end

end
