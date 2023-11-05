class AddPhotoIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :photo_id, :integer
  end
end
