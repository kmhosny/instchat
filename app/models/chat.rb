class Chat < ApplicationRecord
  belongs_to :app, counter_cache: true
  has_many :messages,  dependent: :destroy

  before_create :last_chatapp_index

  def last_chatapp_index
    self.cid = app.chats.size + 1
    self.cid
  end
end
