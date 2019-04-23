class MessageCache
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body, type: String
  field :chat_id, type: Integer
  field :app_id, type: String
  field :written, type: Boolean
end
