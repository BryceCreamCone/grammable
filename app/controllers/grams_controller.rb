class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @grams = Gram.all
    @comment = Comment.new
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return forbidden if current_user != @gram.user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return forbidden if current_user != @gram.user
    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return forbidden if current_user != @gram.user
    Gram.delete(@gram.id)
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:message, :image)
  end

  def render_not_found
    render plain: 'Not Found', status: :not_found
  end

  def forbidden
    render plain: 'Forbidden', status: :forbidden
  end
  
end
