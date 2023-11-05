class User < ApplicationRecord
  has_many :posts
  has_secure_password
  validates :email, presence: true, uniqueness: true
  # validates :first_name, :last_name, presence: true
end
