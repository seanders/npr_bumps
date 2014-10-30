class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.integer :external_id
      t.integer :user_id
      t.integer :external_owner_id
      t.boolean :public
      t.boolean :collaborative

      t.timestamps
    end
  end
end
