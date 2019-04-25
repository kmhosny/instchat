require 'test_helper'

class V1::ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app1 = apps(:one)
    @chat1 = Chat.create(app: @app1)
  end

  test "should get index" do
    get "/v1/apps/#{@app1.id}/chats" ,as: :json
    assert_response :success
    parsed_response = JSON.parse(response.body)
    assert_equal @app1.chats.count, parsed_response.count
  end

  test "should create new app" do
    post "/v1/apps/#{@app1.id}/chats", as: :json
    assert_response :success
    parsed_response = JSON.parse(response.body)
    assert_equal @app1.id, parsed_response['app_id']
  end
end
