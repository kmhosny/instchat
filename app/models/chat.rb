class Chat < ApplicationRecord
  self.primary_keys = :id, :app_id
  belongs_to :app
  has_many :messages

  before_create :last_chatapp_index

  def last_chatapp_index
    self.id = [app.chats.count + 1, self.id[1]]
    self.id
  end
end
