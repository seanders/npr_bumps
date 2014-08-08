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
  let(:episode)  { create(:episode) }
  describe '#parse_tracks_data_from_html' do
  end
end
