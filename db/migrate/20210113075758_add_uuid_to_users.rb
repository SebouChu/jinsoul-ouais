class AddUuidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uuid, :string

    User.all.each { |user|
      user.send(:generate_uuid)
      user.save
    }

    change_column_null :users, :uuid, false
  end
end
