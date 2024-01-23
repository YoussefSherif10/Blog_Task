class Api::V1::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[show update destroy]
  before_action :check_login, only: [:create]
  before_action :check_owner, only: %i[update destroy]

  def index
    comments = @post.comments.page(params[:page]).per(params[:per_page])
    options = links("api_v1_post_comments_path", comments)
    render json: CommentSerializer.new(comments, options).serializable_hash, status: :ok
  end

  def show
    render json: CommentSerializer.new(@comment, { include: [:post] }).serializable_hash, status: :ok
  end

  def create
    comment = @post.comments.build(comment_params.merge(user: current_user))
    if comment.save
      render json: CommentSerializer.new(comment).serializable_hash, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: CommentSerializer.new(@comment).serializable_hash, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      head(:no_content)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def check_owner
    head(:forbidden) unless @comment.user_id == current_user&.id
  end
end
