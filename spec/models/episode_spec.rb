# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  npr_id     :integer
#  date       :datetime
#  url        :string(255)
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Episode do
  pending "add some examples to (or delete) #{__FILE__}"
end
