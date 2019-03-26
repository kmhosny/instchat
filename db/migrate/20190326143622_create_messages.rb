class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, id: false do |t|
      t.integer :id
      t.text :body
      t.references :chat
      t.references :app, type: :string

      t.timestamps
    end
    add_index :messages, [:id, :chat_id, :app_id], unique: true
  end
end
