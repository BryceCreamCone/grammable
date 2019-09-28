class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return not_found if @gram.blank?
    @gram.comments.create(comment_params.merge(user: current_user))
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def not_found
    render plain: 'Not Found', status: :not_found 
  end
end
