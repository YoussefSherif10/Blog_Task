class DeletePostJob
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find_by(id: post_id)
    post.destroy if post
  end

  def self.remove_scheduled_job(post_id)
    scheduled_jobs = Sidekiq::ScheduledSet.new
    scheduled_jobs.each do |job|
      job.delete if job.klass == self.name && job.args == [post_id]
    end
  end
end
