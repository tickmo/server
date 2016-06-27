class GalleriesController < AuthorizedPagesController
  def index
    @full_gallery = @user.screenshots
  end

  private

  ####################################################################################################################

  def set_user
    @user = User.find(params[:user_id])
  end
end
