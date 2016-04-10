class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, except: :create

  def show
    user = User.find(params[:id])

    render(json: Api::V1::UserSerializer.new(user).to_json)
  end

  def index
    users = User.all
    users = apply_filters(users, params)

    render(json: ActiveModel::ArraySerializer.new(users, each_serializer: Api::V1::UserSerializer, root: 'users'))
  end

  def create
    user = User.new(create_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!

    render(json: Api::V1::UserSerializer.new(user).to_json, status: 201, location: api_v1_user_path(user.id))
  end

  def update
    user = User.find(params[:id])
    return api_error(status: 422, errors: user.errors) unless user.update_attributes(create_params)

    render(json: Api::V1::UserSerializer.new(user).to_json, status: 200, location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer)
  end

  def destroy
    user = User.find(params[:id])

    return api_error(status: 500) unless user.destroy
    head status: 204
  end

  private

  ####################################################################################################################

  def create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation).delete_if { |_k, v| v.nil? }
  end
end
