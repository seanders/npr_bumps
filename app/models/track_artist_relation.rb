# == Schema Information
#
# Table name: track_artist_relations
#
#  id         :integer          not null, primary key
#  track_id   :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class TrackArtistRelation < ActiveRecord::Base
  belongs_to :track
  belongs_to :artist
end
