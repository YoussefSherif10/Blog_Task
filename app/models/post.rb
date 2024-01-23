class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :filter_by_title, lambda { |query| where("lower(title) LIKE ?", "%#{query.downcase}%") }
  scope :sort_by_creation, lambda { order(created_at: :asc) }
  scope :recent, lambda { order(updated_at: :desc) }
  scope :filter_by_tag, lambda { |tag| where("tags LIKE ?", "%#{tag}%") }

  def self.search(params = {})
    posts = Post.all
    posts = posts.filter_by_title(params[:title]) if params[:title]
    posts = posts.filter_by_tag(params[:tag]) if params[:tag]
    posts = posts.recent if params[:recent]
    posts = posts.sort_by_creation if params[:sort_by_creation]
    posts
  end
end
