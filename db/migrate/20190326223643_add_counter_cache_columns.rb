class AddCounterCacheColumns < ActiveRecord::Migration[5.2]
  def up
    add_column :apps, :chats_count, :integer, default: 0
    add_column :chats, :messages_count, :integer, default: 0
    App.find_each do |a|
      a.update(chats_count: a.chats.count)
    end

    Chat.find_each do |c|
      c.update(messages_count: c.messages.count)
    end
  end

  def down
    remove_column :apps, :chats_count
    remove_column :chats, :messages_count
  end
end
