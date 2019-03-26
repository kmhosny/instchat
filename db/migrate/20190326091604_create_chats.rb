class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats, id: false do |t|
      t.integer :id
      t.timestamps
    end
    add_reference :chats, :app, foreign_key: true, type: :string
    add_index :chats, [:id, :app_id], unique: true
  end
end
