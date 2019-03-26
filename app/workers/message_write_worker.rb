class MessageWriteWorker
  include Sidekiq::Worker

  def perform
    res = Redis.current.blpop('pending_messages', 5)
    unless res.nil?
      data = JSON.parse(res[1])
      Message.transaction do
        message = Message.create!(body: data["body"], chat_id: data["chat_id"], app_id: data["app_id"])
        c = Chat.find_by(id: data["chat_id"], app_id: data["app_id"])
        c.update(messages_count: c.messages.size)
      end
    end
    MessageWriteWorker.perform_async
  end
end
