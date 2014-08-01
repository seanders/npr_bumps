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

  def find_or_create_from_oauth(auth_obj)
    linked_account = LinkedAccount.
                      where(uid: auth_obj.uid, type: auth_obj.type).
                      first_or_initialize(auth_obj.linked_account_attributes)

    if linked_account.persisted?
      return linked_account.person
    else
      person = Person.create(email: auth['email'], name: auth['name'])
      linked_account.person = person
      linked_account.save!
      return linked_account.person
    end
  end
end
