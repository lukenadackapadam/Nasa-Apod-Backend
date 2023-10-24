class PostsController < ApplicationController
  def create
    @post = Post.create(
      user_id: current_user.id,
      comment: params[:comment]
    )
    if @post.save
      render json: { message: "Post created successfully" }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :bad_request
    end
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.update(
      comment: params[:comment] || @post.comment,
    )
    if @post.save
      render json: { message: "Post updated successfully!" }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
