class PostsController < ApplicationController
  def index
    @posts = Post.all()
    render :index
  end

  def posts_by_photo
    posts = Post.where(photo_id: params[:photo_id])
    render json: posts
    pp(posts)
  end

  def create
    post = Post.create(
      user_id: current_user.id,
      photo_id: params[:photo_id],
      post: params[:post],
    )
    if post.save
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
