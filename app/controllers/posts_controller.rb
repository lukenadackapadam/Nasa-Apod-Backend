class PostsController < ApplicationController
  def index
    @posts = Post.all()
    render :index
  end

  def posts_by_photo
    posts = Post.where(photo_id: params[:photo_id])
    user_can_post = !posts.any? { |post| post.user_id == current_user.id}  
    posts_data = {posts: posts, user_can_post: user_can_post}
    pp posts_data 
    render json: posts_data
  end

  def create
    # TODO: Verify user hasn't posted. 
    puts params
    post = Post.create(
      user_id: current_user.id,
      post: params[:post],
      photo_id: params[:photo_id],
    )
    if post.save
      # posts_by_photo to stop re-render 
      render json: { message: "Post created successfully" }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end
  
  def update
    post = Post.find_by(id: params[:id])
    post.update(
      comment: params[:comment] || post.comment,
    )
    if post.save
      render json: { message: "Post updated successfully!" }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    render json: { message: "Post removed successfully!" }
  end
end
