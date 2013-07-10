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
    # move lines 16
    friend = Friend.find_or_create_by_name_and_user_id(params[:occasion][:friend_name], current_user.id)

    occasion = friend.occasions.build(params[:occasion])

    if occasion.save
      render :json => render_to_string(partial: "layouts/occasion", locals: {occasion: occasion}).to_json
    else
      # if errors render something back in json with error messages
    end
  end

  def edit
    @occasion = Occasion.find(params[:id])
    # use load_and_authorize_resource
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
