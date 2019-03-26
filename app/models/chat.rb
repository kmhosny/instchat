class Chat < ApplicationRecord
  self.primary_keys = :id, :app_id
  belongs_to :app, counter_cache: true
  has_many :messages,  dependent: :destroy

  before_create :last_chatapp_index

  def last_chatapp_index
    self.id = [app.chats.size + 1, self.id[1]]
    self.id
  end
end
