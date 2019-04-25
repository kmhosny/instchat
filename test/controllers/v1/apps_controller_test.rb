require 'test_helper'

class V1::AppsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_apps_url, as: :json
    assert_response :success
    parsed_response = JSON.parse(response.body)
    assert_equal apps.count, parsed_response.count
  end

  test "should create new app" do
    post v1_apps_url, params: { name: 'App3' }, as: :json
    assert_response :success
    parsed_response = JSON.parse(response.body)
    assert_equal 'App3', parsed_response['name']
  end
end
