# == Schema Information
#
# Table name: linked_accounts
#
#  id            :integer          not null, primary key
#  uid           :integer
#  person_id     :integer
#  type          :string(255)
#  email         :string(255)
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
end
