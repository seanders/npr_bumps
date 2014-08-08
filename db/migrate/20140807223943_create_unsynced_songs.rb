class CreateUnsyncedSongs < ActiveRecord::Migration
  def change
    create_table :unsynced_songs do |t|
      t.string :raw_html

      t.timestamps
    end
  end
end
