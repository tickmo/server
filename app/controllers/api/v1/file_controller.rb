class Api::V1::FileController < Api::V1::BaseController
  skip_before_filter :verify_authenticity_token

  UTF8_ENCODING = Encoding::UTF_8
  DATA_DIR = 'public/data'
  
  def create
    Dir.mkdir(DATA_DIR) unless Dir.exist?(DATA_DIR)


    params[:screenshots].each do |file|
      path = File.join(DATA_DIR, file.original_filename)
      File.open(path, "wb") do |data|

        byebug

        data.encode(UTF8_ENCODING) if data.read.encoding != UTF8_ENCODING
        data.write

        return api_error(status: 422, errors: user.errors) unless File.exist?(path)
        render json: { success: 'data saved' }, status: 200
      end
    end
  end
end