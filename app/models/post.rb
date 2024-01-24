class Post < ApplicationRecord
  after_create :schedule_deletion
  before_destroy :remove_scheduled_deletion

  validates :title, presence: true
  validates :body, presence: true
  validate :tags_array
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

  private

  def remove_scheduled_deletion
    DeletePostJob.remove_scheduled_job(self.id)
  end

  def tags_array
    errors.add(:tags, "must be an array of strings") unless tags.is_a?(Array)
    errors.add(:tags, "must have at least one tag") if tags.empty?
  end

  def schedule_deletion
    DeletePostJob.perform_in(24.hours, self.id)
  end
end
