class AddOmniauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :discord_uid, :string
  end
end
