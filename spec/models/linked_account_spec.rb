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

require 'spec_helper'

describe LinkedAccount do
  pending "add some examples to (or delete) #{__FILE__}"
end
