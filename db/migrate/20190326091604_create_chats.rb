class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats, id: false do |t|
      t.integer :id
      t.references :app, foreign_key: true
      t.timestamps
      t.index [:id, :app_id]
    end
  end
end
