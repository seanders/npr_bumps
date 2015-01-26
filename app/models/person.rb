# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Person < ActiveRecord::Base
  has_many :linked_accounts
  has_many :playlists

  validates :email, presence: true

  def self.find_or_create_from_oauth(auth_obj)
    linked_account = LinkedAccount.find_or_initialize(auth_obj)

    if linked_account.persisted?
      linked_account.update_from_oauth(auth_obj)
      return linked_account.person
    else
      linked_account.person = Person.create(email: auth_obj.email, name: auth_obj.name)
      linked_account.save!
      return linked_account.person
    end
  end

  def spotify_account
    @spotify_account ||= linked_accounts.where(type: 'LinkedAccount::Spotify').first
  end

  def spotify_oauth_token
    # will handle refreshening logic if necessary
    spotify_account.valid_oauth_token
  end

  def spotify_id
    spotify_account.uid
  end

  def batch_create_or_update_playlists(playlist_attributes_array)
    ActiveRecord::Base.transaction do
      playlist_attributes_array.each do |playlist_attributes_hash|
        # find or init a new playlist for the user
        playlist = playlists.find_or_initialize_by(name: playlist_attributes_hash['name'], external_owner_id: playlist_attributes_hash['owner']['id'])
        # save attributes from spotify
        playlist.update_attributes!(
          external_id: playlist_attributes_hash['id'],
          external_owner_id: playlist_attributes_hash['owner']['id'],
          public: playlist_attributes_hash['public'],
          collaborative: playlist_attributes_hash['collaborative']
        )
      end
    end
  end
end
