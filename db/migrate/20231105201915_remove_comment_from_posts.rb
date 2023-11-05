class RemoveCommentFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :comment, :text
  end
end
