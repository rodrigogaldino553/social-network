class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :follow, :unfollow, :followers, :followees]

  def index
    @users = User.all

    #@q = User.ransack(params[:q])
    #@pagy, @users = pagy(@q.result(dinstinct: true))

    #authorize @users
  end

  def show
    #authorize @user
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

  def follow
    # @user = User.find(params[:id])
    current_user.followees << @user
    redirect_back(fallback_location: user_path(@user))
  end
  
  def unfollow
    # @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end

  def followers
    @followers = @user.followers
    respond_to do |format|
      format.html { render 'users/follows', locals: {user: @user, followers: @followers} }
    end
  end

  def followees
    @followees = @user.followees
    respond_to do |format|
      format.html { render 'users/follows', locals: {user: @user, followees: @followees} }
    end
  end

  def review_user
  end

  def unreviewd_user
    render 'Your account is being reviewed by our, wait the approve!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:email, :password, :password_confirmation, :avatar, :name, :status])
  end
end