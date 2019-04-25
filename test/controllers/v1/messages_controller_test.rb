require 'test_helper'

class V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app1 = App.create(name: "App 1")
    @chat1 = Chat.create(app: @app1)
  end
  test "should create new message" do
    cache_count = MessageCache.count
    post "/v1/apps/#{@app1.id}/chats/#{@chat1.cid}/messages", params:{ body: "Hello Chat App1" } , as: :json
    assert_response :success
    parsed_response = JSON.parse(response.body)
    assert_includes MessageCache.pluck(:body), "Hello Chat App1"
    assert_equal cache_count+1, MessageCache.count
  end
end
