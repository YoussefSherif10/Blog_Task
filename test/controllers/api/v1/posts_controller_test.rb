require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get api_v1_posts_url
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should show post" do
    get api_v1_post_url(@post)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @post.title, json_response["title"]
  end

  test "should create post" do
    assert_difference("Post.count") do
      post api_v1_posts_url, params: { post: { title: "New Post", body: "A new post body.", tags: ["tag1", "tag2"] } }
    end
    assert_response :created
  end

  test "should not create post with invalid params" do
    assert_no_difference("Post.count") do
      post api_v1_posts_url, params: { post: { title: "", body: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update post" do
    patch api_v1_post_url(@post), params: { post: { title: "Updated Title" } }
    assert_response :success
  end

  test "should not update post with invalid params" do
    patch api_v1_post_url(@post), params: { post: { title: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete api_v1_post_url(@post)
    end
    assert_response :no_content
  end
end
