class Message < ApplicationRecord
  self.primary_keys = :id, :chat_id, :app_id
  searchkick
  belongs_to :chat, class_name: "Chat", foreign_key: "chat_id",dependent: :destroy, counter_cache: true
  belongs_to :chat, class_name: "Chat", foreign_key: "app_id"

  validates :body, presence: true
  before_create :last_chatmessage_index

  def chat=(ch)
    self.chat_id = ch.id[0]
    self.app_id = ch.id[1]
  end

  def chat
    Chat.find_by(id: self.chat_id, app_id: self.app_id)
  end

  def last_chatmessage_index
    self.id = [chat.messages.size + 1, self.id[1], self.id[2]]
    self.id
  end

  def search_data
    {
      body: body,
      chat_id: chat_id,
      app_id: app_id
    }
  end
end
