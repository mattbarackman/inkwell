class OccasionsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @upcoming_orders = current_user.upcoming_orders.sort_by {|order| order.occasion.date}
    @future_orders = current_user.future_orders.sort_by {|order| order.occasion.date}
  end

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

  def ajax_get
    upcoming_orders = current_user.upcoming_orders.sort_by {|order| order.occasion.date}.map { |order| { :id => order.id, :date => order.occasion.date, :friend => order.occasion.friend.name.titleize, :name => order.occasion.name.titleize } }
    future_orders = current_user.future_orders.sort_by {|order| order.occasion.date}.map { |order| { :id => order.id, :date => order.occasion.date, :friend => order.occasion.friend.name.titleize, :name => order.occasion.name.titleize } }
    render json: { :upcoming => upcoming_orders, :future => future_orders }
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
