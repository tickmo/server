class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[a-z\.\-\d]+@+[a-z]+.{1}+[a-z]+\z/x

  has_secure_password
  before_save { email.downcase! }
  before_create :generate_api_authentication_token
  after_create :send_welcome_mail
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: true }
  validates :password, length: { minimum: 6 }

  has_many :screenshots

  def self.new_token
    SecureRandom.urlsafe_base64(64)
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  #####################################################################################################################

  def generate_api_authentication_token
    loop do
      self.api_authentication_token = User.new_token
      break unless User.find_by_api_authentication_token(api_authentication_token)
    end
  end

  def send_welcome_mail
    UserMail.welcome_email(self).deliver_now
  end
end
