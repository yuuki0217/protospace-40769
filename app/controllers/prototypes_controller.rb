class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destrou]
  before_action :move_to_index, except:  [:index, :show, :new, :create, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new 
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to '/'
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end

  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

def move_to_index
  unless current_user == user_signed_in?
    redirect_to action: :index
  end
end


end
