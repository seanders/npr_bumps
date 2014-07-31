class CreateLinkedAccounts < ActiveRecord::Migration
  def change
    create_table :linked_accounts do |t|
      t.integer :uid
      t.string :image_url
      t.string :oauth_token
      t.string :refresh_token
      t.string :expires_at
      t.integer :expires_in

      t.timestamps
    end
  end
end
