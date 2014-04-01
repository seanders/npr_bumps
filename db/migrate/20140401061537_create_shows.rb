class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.date :date
      t.integer :program_id
      t.timestamps
    end

    add_index :shows, :date
    add_index :shows, :program_id
  end
end
