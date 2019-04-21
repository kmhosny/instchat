class Message < ApplicationRecord
  searchkick
  belongs_to :chat, class_name: "Chat", foreign_key: "chat_id",dependent: :destroy, counter_cache: true

  validates :body, presence: true
  before_create :last_chatmessage_index

  def last_chatmessage_index
    self.mid = chat.messages.size + 1
    self.mid
  end

  def search_data
    {
      body: body,
      chat_id: chat.id,
      app_id: chat.app.id
    }
  end
end
