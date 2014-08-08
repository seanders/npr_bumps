# == Schema Information
#
# Table name: programs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :string(255)
#  slug       :string(255)
#  npr_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Program do
  before(:each) do
    @program = Program.new()
    @program.stub(:slug) { "all-things-considered" }
  end

end
