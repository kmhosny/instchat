require_relative '../test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!
class MessageWriteWorkerTest < MiniTest::Unit::TestCase
  def test_example
    app = App.create(name: 'CronJobApp')
    chat = Chat.create(app: app)
    chats_count = chat.messages.count
    mc = MessageCache.create(app_id: app.id, chat_id: chat.id, body: 'Message Cache CronJob', written: false)
    msg_count = Message.count
    MessageWriteWorker.perform_async
    assert_equal msg_count + 1, Message.count
    mc.reload
    assert_equal mc.written, true
    chat.reload
    assert_equal chat.messages.count, chats_count + 1
  end
end
