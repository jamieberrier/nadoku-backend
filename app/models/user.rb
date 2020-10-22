class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: { case_sensitive: false }
  validates :username, presence: true
end
