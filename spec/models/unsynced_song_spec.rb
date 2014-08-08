# == Schema Information
#
# Table name: unsynced_songs
#
#  id         :integer          not null, primary key
#  raw_html   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe UnsyncedSong do
  pending "add some examples to (or delete) #{__FILE__}"
end
