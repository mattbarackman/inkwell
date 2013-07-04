class OccasionsController < ApplicationController

  before_filter :authenticate_user!
  
  def new
    @occasion = Occasion.new
  end
  
  def create
    occasion = Occasion.new
    if occasion.update_attributes(params[:occasion])
      redirect_to '/occasions'
    else
      redirect_to '/occasions/new'
    end		
  end

  def edit
    @occasion = Occasion.find(params[:id])
    redirect_to user_root_path unless @occasion && @occasion.friend.user == current_user
  end

  def update
    occasion = Occasion.find(params[:id])
    if occasion && occasion.friend.user == current_user && occasion.update_attributes(params[:occasion])
      redirect_to occasions_path
    else
      redirect_to user_root_path
    end
  end

end
