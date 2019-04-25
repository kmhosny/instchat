require 'test_helper'

class MessageCachesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_cach = MessageCache.create(app_id: "Zijore38943", body: "Hi Man", chat_id: 231)
  end

  test "should get index" do
    get message_caches_url, as: :json
    assert_response :success
  end

  test "should create message_cach" do
    assert_difference('MessageCache.count') do
      post message_caches_url, params: { message_cach: { app_id: @message_cach.app_id, body: @message_cach.body, chat_id: @message_cach.chat_id } }, as: :json
    end

    assert_response 201
  end

  test "should show message_cach" do
    get message_cach_url(@message_cach), as: :json
    assert_response :success
  end

  test "should update message_cach" do
    patch message_cach_url(@message_cach), params: { message_cach: { app_id: @message_cach.app_id, body: @message_cach.body, chat_id: @message_cach.chat_id } }, as: :json
    assert_response 200
  end

  test "should destroy message_cach" do
    assert_difference('MessageCache.count', -1) do
      delete message_cach_url(@message_cach), as: :json
    end

    assert_response 204
  end
end
