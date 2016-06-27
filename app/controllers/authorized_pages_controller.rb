class AuthorizedPagesController < ApplicationController
  before_action :set_user, :signed_in_user, :correct_user

  protected

  ####################################################################################################################

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
    redirect_to root_path, notice: 'You already have account.' unless current_user?(@user)
  end

  def signed_in_user
    redirect_to signin_path, notice: 'Please, sign in.' unless signed_in?
  end
end
