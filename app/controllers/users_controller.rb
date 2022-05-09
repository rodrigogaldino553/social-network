class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all

    #@q = User.ransack(params[:q])
    #@pagy, @users = pagy(@q.result(dinstinct: true))

    #authorize @users
  end

  def show
    @pictures = Picture.where(user_id: @user.id)
  end

  def edit
    #authorize @user
  end

  # def update
  #   #authorize @user
  #   if @user.update(user_params)
  #     redirect_to users_path, notice: "User #{@user.email} was succefully updated"
  #   else
  #     binding.pry
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:email, :password, :password_confirmation, :avatar, :name, :description])
  end
end