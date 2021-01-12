class AddFromDiscordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :from_discord, :boolean, default: false
  end
end
