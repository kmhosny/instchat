class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :uid
      t.string :name, null: false
      t.timestamps
      t.index :uid, unique: true
    end
  end
end
