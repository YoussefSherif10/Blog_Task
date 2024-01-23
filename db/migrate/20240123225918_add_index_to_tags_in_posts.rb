class AddIndexToTagsInPosts < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, :tags
  end
end
