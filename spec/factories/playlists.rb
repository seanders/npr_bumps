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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlist do
    name "MyString"
    sequence(:external_id)
    person
    sequence(:external_owner_id)
    public false
    collaborative false
  end
end
