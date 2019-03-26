class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps, id: false do |t|
      t.string :id, index: true, unique: true, primary_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
