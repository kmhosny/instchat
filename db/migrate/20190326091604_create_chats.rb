class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :cid
      t.timestamps
    end
    add_reference :chats, :app, foreign_key: true, type: :string
    add_index :chats, [:cid, :app_id], unique: true
  end
end
