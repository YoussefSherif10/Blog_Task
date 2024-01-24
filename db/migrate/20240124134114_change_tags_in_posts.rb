class ChangeTagsInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :tags, :string, array: true, default: [], using: "(string_to_array(tags, ','))"
  end
end
