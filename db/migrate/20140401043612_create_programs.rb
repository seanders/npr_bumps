class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :programs, :name
    add_index :programs, :url
  end
end
