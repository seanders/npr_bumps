# == Schema Information
#
# Table name: album_artist_relations
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class AlbumArtistRelation < ActiveRecord::Base
end
