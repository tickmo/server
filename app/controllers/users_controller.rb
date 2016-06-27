class UsersController < AuthorizedPagesController
  skip_before_action :set_user, only: [:index, :new, :create]
  skip_before_action :signed_in_user, only: [:create, :new]
  skip_before_action :correct_user, except: [:edit, :update, :show]
  skip_before_action :admin_user, except: :destroy
  skip_before_action :registered_user, except: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @screenshots = @user.screenshots
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
      flash[:success] = 'Profile was successfully updated'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.admin?
      redirect_to users_path, notice: "Can\'t delete admin account."
    else
      @user.destroy
      flash[:success] = 'User profile deleted'
      redirect_to users_path
    end
  end

  private

  ####################################################################################################################

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
