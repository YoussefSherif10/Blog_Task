class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]

  def show
    render json: UserSerializer.new(@user, { include: [:posts] }).serializable_hash
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head(:no_content)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head(:forbidden) unless @user.id == current_user&.id
  end
end
