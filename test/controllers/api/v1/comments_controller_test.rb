require "test_helper"

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get api_v1_post_comments_url(@post)
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should show comment" do
    get api_v1_post_comment_url(@post, @comment)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @comment.content, json_response["content"]
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post api_v1_post_comments_url(@post), params: { comment: { content: "New comment" } }
    end
    assert_response :created
  end

  test "should not create comment with invalid params" do
    assert_no_difference("Comment.count") do
      post api_v1_post_comments_url(@post), params: { comment: { content: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update comment" do
    patch api_v1_post_comment_url(@post, @comment), params: { comment: { content: "Updated content" } }
    assert_response :success
  end

  test "should not update comment with invalid params" do
    patch api_v1_post_comment_url(@post, @comment), params: { comment: { content: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete api_v1_post_comment_url(@post, @comment)
    end
    assert_response :no_content
  end
end
