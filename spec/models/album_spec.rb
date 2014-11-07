# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  artist_id  :integer
#  spotify_id :string(255)
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Album do
  pending "add some examples to (or delete) #{__FILE__}"
end
