class ChatSerializer < ActiveModel::Serializer
  attributes :id, :app_id

  def id
    object.id[0]
  end
end
