class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :tags
  belongs_to :user
  has_many :comments
end
