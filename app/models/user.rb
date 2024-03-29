class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_format_of :email, with: /@/
  validates :name, presence: true
  validates :password_digest, presence: true
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
