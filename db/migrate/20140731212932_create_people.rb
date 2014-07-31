class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :spotify_id
      t.string :name
      t.string :image_url
      t.string :token
      t.string :refresh_token
      t.string :expires_at
      t.integer :expires_in

      t.timestamps
    end
  end
end
