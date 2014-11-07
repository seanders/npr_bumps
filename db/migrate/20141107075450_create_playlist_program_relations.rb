class CreatePlaylistProgramRelations < ActiveRecord::Migration
  def change
    create_table :playlist_program_relations do |t|
      t.references :playlist
      t.references :program

      t.timestamps
    end
  end
end
