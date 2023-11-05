class RemoveUpvoteFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :upvote, :integer
  end
end
