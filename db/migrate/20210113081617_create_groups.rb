class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :uuid, null: false
      t.string :name

      t.timestamps
    end
  end
end
