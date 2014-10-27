# == Schema Information
#
# Table name: linked_accounts
#
#  id            :integer          not null, primary key
#  uid           :integer
#  person_id     :integer
#  type          :string(255)
#  email         :string(255)
#  name          :string(255)
#  image_url     :string(255)
#  oauth_token   :string(255)
#  refresh_token :string(255)
#  expires_at    :string(255)
#  expires_in    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class LinkedAccount < ActiveRecord::Base
  # relations
  belongs_to :person

  # validations
  validates :uid, presence: true, numericality: true
  validates :person, presence: true
  validates :oauth_token, presence: true
  validates :type, presence: true


  def self.find_or_initialize(auth_obj)
    where(uid: auth_obj.uid, type: param_to_type(auth_obj.type)).
      first_or_initialize(convert_auth_obj_to_attributes(auth_obj))
  end

  def update_from_oauth(auth_obj)
    attributes_to_update = auth_obj.to_h.select {|key, value| updateable_attributes.include?(key) }
    update_attributes(attributes_to_update)
  end

  private

  def updateable_attributes
    %i(name email image_url oauth_token refresh_token expires_at)
  end

  def self.convert_auth_obj_to_attributes(auth_object)
    {
      uid: auth_object.uid,
      type: param_to_type(auth_object.type),
      name: auth_object.name,
      email: auth_object.email,
      image_url: auth_object.image_url,
      oauth_token: auth_object.oauth_token,
      refresh_token: auth_object.refresh_token,
      expires_at: auth_object.expires_at
    }
  end

  def self.param_to_type(type)
    case type
    when 'spotify'
      'LinkedAccount::Spotify'
    end
  end
end
