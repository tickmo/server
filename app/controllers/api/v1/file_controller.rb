class Api::V1::FileController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :empty_params, only: :create

  def create
    params[:screenshots].each do |screen|
      Screenshot.create(user_id: current_user.id, screenshot_image: screen)
    end
    render json: { success: 'data saved' }, status: 200
  end

  private

  #####################################################################################################################

  def empty_params
    params[:screenshots].each do |screen|
      return api_error(status: 422, errors: 'bad data.') if screen.read.empty?
    end
  end
end
