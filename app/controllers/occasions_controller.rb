class OccasionsController < ApplicationController

  before_filter :authenticate_user!
  
  def new
    @occasion = Occasion.new
  end
  
  def create
    occasion = Occasion.new(params[:occasion])
    try_to_update(occasion, authorize_user: true)
  end

  def edit
    @occasion = Occasion.find(params[:id])
    redirect_to user_root_path unless @occasion && @occasion.user == current_user
  end

  def update
    occasion = Occasion.find(params[:id])
    try_to_update(occasion, authorize_user: true)
  end

  def destroy
    Occasion.delete(params[:id])
    redirect_to occasions_path
  end

  private

  # See try_to_update in ApplicationController

#    def try_to_update(occasion)
#      if occasion && occasion.friend.user == current_user && occasion.update_attributes(params[:occasion])
#        redirect_to occasions_path
#      else
#        redirect_to user_root_path
#      end
#    end

end
