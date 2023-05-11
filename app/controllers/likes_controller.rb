class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    return if @like.after_save

    flash[:alert] = 'You already liked this post'
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
