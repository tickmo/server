class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[a-z\.\-\d]+@+[a-z]+.{1}+[a-z]+\z/x

  has_secure_password
  before_save { email.downcase! }
  # before_create :confirmation_token
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: true }
  validates :password, length: { minimum: 6 }
end
