class UpvotesController < ApplicationController
  def create
    @upvote = Upvote.create (
      user_id: params[:user_id],
      post_id: params[:post_id],
    )
  end

  def destroy
    @upvote = Upvote.find_by(id: params[:id])
    @upvote.destroy
    render json: { message: "Upvote removed successfully!" }
  end
end
