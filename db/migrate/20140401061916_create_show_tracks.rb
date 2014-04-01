class CreateShowTracks < ActiveRecord::Migration
  def change
    create_table :show_tracks do |t|
      t.integer :show_id
      t.integer :track_id

      t.timestamps
    end
  end
end
