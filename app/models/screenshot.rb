class Screenshot < ActiveRecord::Base
  mount_uploader :screenshot_image, ScreenshotUploader
  belongs_to :user
end
