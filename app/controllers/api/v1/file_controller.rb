class Api::V1::FileController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action :exist_dir, only: :create
  before_action :params_verify, only: :create

  UTF8_ENCODING = Encoding::UTF_8
  DATA_DIR = Rails.root.join('public', 'data')

  def create
    params[:screenshots].each do |screen|
      path = Rails.root.join(DATA_DIR, screen.original_filename)
      save_file(path, screen.read)

      return api_error(status: 422, errors: 'file not saved.') unless File.exist?(path)
    end
    render json: { success: 'data saved' }, status: 200
  end

  private

  #####################################################################################################################

  def exist_dir
    Dir.mkdir(DATA_DIR) unless Dir.exist?(DATA_DIR)
  end

  def params_verify
    api_error(status: 422, errors: 'no screenshots sent.') if params[:screenshots].nil?
    api_error(status: 422, errors: 'array is empty.') if params[:screenshots].any?
  end

  def save_file(path, data)
    File.open(path, 'wb') do |file|
      data.force_encoding(UTF8_ENCODING) if data.encoding != UTF8_ENCODING
      file.write(data)
    end
  end
end
