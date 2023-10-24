class PostsController < ApplicationController
  def create
    @post = Post.create(
      user_id: params[:user_id],
      comment: params[:comment],
      upvote: params[:upvote],
    )
    if @post.save
      render json: { message: "Post created successfully" }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :bad_request
    end
  end
end
