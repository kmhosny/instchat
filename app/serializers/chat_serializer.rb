class ChatSerializer < ActiveModel::Serializer
  attributes :id, :app_id

  def id
    object.cid
  end
end
