class MessageWriteWorker
  include Sidekiq::Worker

  def perform
    begin
      MessageCache.where(written: false).each do |m|
        Message.transaction do
          message = Message.create!(body: m.body, chat_id: m.chat_id, created_at: m.created_at)
        end
      end.update_all(written: true)
    rescue Mongoid::Errors::DocumentNotFound => e
      Rails.logger.error e.message
    end
  end
end
