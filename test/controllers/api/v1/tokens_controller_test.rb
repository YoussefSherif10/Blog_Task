require "test_helper"

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  test "should get JWT token" do
    post api_v1_tokens_url, params: { user: { email: "youssef@gmail.com", password: "123456" } }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_nil json_response["token"]
  end

  test "should not get JWT token with invalid credentials" do
    post api_v1_tokens_url, params: { user: { email: "test@example.com", password: "wrong" } }
    assert_response :unauthorized
  end
end
