class MessageCacheSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id, :app_id
end
