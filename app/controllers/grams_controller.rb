class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def show
    render_if_not_found
  end

  def new
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
    render_if_not_found
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_if_not_found
    begin
      @gram = Gram.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render plain: 'Not Found', status: :not_found
    end
  end
  
end
