class Api::V1::FileController < Api::V1::BaseController
  skip_before_filter :verify_authenticity_token
  before_action :exist_dir, only: :create

  UTF8_ENCODING = Encoding::UTF_8
  DATA_DIR = Rails.root.join('public','data')

  def create
    params[:screenshots].each do |screen|
      data = screen.read
      if data.empty?
        return api_error(status: 422, errors: 'bad data.')
      else
        path = Rails.root.join(DATA_DIR, screen.original_filename)
        save_file(path, data)

        return api_error(status: 422, errors: 'file not saved.') unless File.exist?(path)
        render json: { success: 'data saved' }, status: 200
      end
    end
  end

  private
#######################################################################################################################

  def save_file(path, data)
    File.open(path, 'wb') do |file|
      data.force_encoding(UTF8_ENCODING) if data.encoding != UTF8_ENCODING
      file.write(data)
    end
  end

  def exist_dir
    Dir.mkdir(DATA_DIR) unless Dir.exist?(DATA_DIR)
  end
end
