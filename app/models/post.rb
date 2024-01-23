class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :filter_by_title, lambda { |query| where("lower(title) LIKE ?", "%#{query.downcase}%") }
  scope :sort_by_creation, lambda { order(created_at: :asc) }
  scope :recent, lambda { order(updated_at: :desc) }

  def self.search(params = {})
    products = Post.all
    products = products.filter_by_title(params[:title]) if params[:title]
    products = products.recent if params[:recent]
    products = products.sort_by_creation if params[:sort_by_creation]
    products
  end
end
