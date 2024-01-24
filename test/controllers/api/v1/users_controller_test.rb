require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_valid = users(:one)
    @user_invalid = users(:two)
  end

  test "should show user" do
    get api_v1_user_url(@user_valid)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @user_valid.name, json_response["name"]
  end

  test "should create user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: { name: "New User", email: "newuser@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_response :created
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post api_v1_users_url, params: { user: { name: "", email: "bademail", password: "short", password_confirmation: "short" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch api_v1_user_url(@user_valid), params: { user: { name: "Updated Name" } }
    assert_response :success
  end

  test "should not update user with invalid params" do
    patch api_v1_user_url(@user_valid), params: { user: { email: "invalidemail" } }
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user_valid)
    end
    assert_response :no_content
  end
end
