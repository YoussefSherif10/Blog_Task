class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content
  belongs_to :user
  belongs_to :post
end
