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
  has_many :subscriptions, source: :program, through: :playlist_program_relations
  has_many :playlist_program_relations

end
