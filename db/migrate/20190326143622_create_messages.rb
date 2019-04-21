class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :mid
      t.text :body
      t.references :chat

      t.timestamps
    end
    add_index :messages, [:mid, :chat_id], unique: true
  end
end
