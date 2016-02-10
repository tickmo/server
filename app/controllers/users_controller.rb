class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy, :index]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  before_action :registered_user, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile was successfully updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.admin?
      redirect_to users_path, notice: "Can't delete admin account."
    else
      @user.destroy
      flash[:success] = "User profile deleted"
      redirect_to users_path
    end
  end

  private
######################################################################################################################

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filter.

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def registered_user
    redirect_to root_path, notice: "You already have account." unless current_user?(@user)
  end

  def signed_in_user
    unless signed_in?
      redirect_to signin_path, notice: "Please, sign in."
    end
  end
end
