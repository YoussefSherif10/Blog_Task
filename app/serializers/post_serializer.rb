class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body
  belongs_to :user
  has_many :comments
end
