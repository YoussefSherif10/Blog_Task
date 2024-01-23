class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :image
end
