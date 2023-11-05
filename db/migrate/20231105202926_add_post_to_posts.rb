class AddPostToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :post, :text
  end
end
