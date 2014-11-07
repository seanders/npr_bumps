class CreatePlaylistProgramRelations < ActiveRecord::Migration
  def change
    create_table :playlist_program_relations do |t|
      t.playlist :references
      t.program :references

      t.timestamps
    end
  end
end
