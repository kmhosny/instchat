class Chat < ApplicationRecord
  self.primary_keys = :id, :app_id
  belongs_to :app
  before_save :last_chatapp_index

  def last_chatapp_index
    byebug
    self.id = [app.chats.count + 1, self.id[1]] if id_was[0].nil?
    self.id
  end
end
