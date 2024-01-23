class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :image
  has_many :posts
  has_many :comments
end
