# json.extract! post, :id, :user_id, :photo_id, :post, :created_at, :updated_at

json.id post.id
json.user_id post.user_id
json.photo post.photo
json.post post.post
json.created_at post.created_at
json.updated_at post.updated_at