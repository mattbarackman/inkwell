class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(params[:order])
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.update_attributes(params[:order])
    if @order.save
      redirect_to @order
    else
      render :edit
    end
  end

  def create_card
    @order = Order.find_by_occasion_id(params[:occasion][:id])
    card = Card.find(params[:card_id])
    @order.card = card
    if @order.save
      flash[:success] = "Thanks for picking a card!"
      redirect_to :back
    else
      render card
    end    
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to :back
  end

  def ajax_get
    upcoming_orders = current_user.upcoming_orders.sort_by {|order| order.occasion.date}
    future_orders = current_user.future_orders.sort_by {|order| order.occasion.date}

    upcoming_orders.map! { |order| order.ajax_hash }
    future_orders.map! { |order| order.ajax_hash }

    render json: { :upcoming => upcoming_orders, :future => future_orders }
  end

  def ajax_post
    order = Order.find(params[:id])
    order.card_id = params[:card_id].to_i if params[:card_id]
    order.save
    render json: order, status: :ok
  end

end
