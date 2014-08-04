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

  validates :email, presence: true

  def self.find_or_create_from_oauth(auth_obj)
    linked_account = LinkedAccount.find_or_initialize(auth_obj)

    if linked_account.persisted?
      return linked_account.person
    else
      linked_account.person = Person.create(email: auth_obj.email, name: auth_obj.name)
      linked_account.save!
      return linked_account.person
    end
  end
end
