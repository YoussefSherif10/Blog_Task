class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :check_login, only: [:create]
  before_action :check_owner, only: %i[update destroy]

  def show
    render json: PostSerializer.new(@post, { include: [:comments] }).serializable_hash, status: :ok
  end

  def index
    posts = Post.page(params[:page]).per(params[:per_page]).search(params)
    options = links("api_v1_posts_path", posts)
    render json: PostSerializer.new(posts, options).serializable_hash, status: :ok
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: PostSerializer.new(post).serializable_hash, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post).serializable_hash, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head(:no_content)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_owner
    head(:forbidden) unless @post.user_id == current_user&.id
  end
end
