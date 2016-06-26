class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: :create

  def create
    user = User.find_by(email: create_params[:email])
    return api_error(status: 401) if user.nil?
    return api_error(status: 401) unless user.authenticate(create_params[:password])

    self.current_user = user
    user.update_attribute(:api_authentication_token, User.new_token)
    render(json: Api::V1::SessionSerializer.new(user, root: false).to_json, status: 201)
  end

  private

  #####################################################################################################################

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
