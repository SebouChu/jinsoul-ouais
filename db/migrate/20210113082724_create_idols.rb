class CreateIdols < ActiveRecord::Migration[6.1]
  def change
    create_table :idols do |t|
      t.string :uuid, null: false
      t.string :name
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
