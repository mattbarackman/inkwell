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
    @order = Order.find(params[:id])
    p @order
    p params[:order]
    status = params[:order].first[:status]
    if status
      @order.status = status
      params[:order].first.delete(:status)
    end 
    @order.update_attributes(params[:order].first)
    if @order.save
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.status = "no_card"
    order.card = nil
    order.save
    redirect_to :back
  end

  def ajax_get
    not_purchased_orders = current_user.orders.select {|order| order.status == "no_card" || order.status == "in_cart" }.sort_by {|order| order.event_date}
    
    last_order_added = not_purchased_orders.sort { |a,b| a.id <=> b.id }.last
    last_order_index = not_purchased_orders.index { |order| order.id == last_order_added.id }

    not_purchased_orders.map! { |order| order.ajax_hash }

    render json: { :not_purchased_orders => not_purchased_orders, :last_order_index => last_order_index }
  end

  def ajax_post
    order = Order.find(params[:id])
    order.card_id = params[:card_id].to_i if params[:card_id]
    order.save

    orders_in_cart = current_user.orders.select {|order| order.status == "in_cart" }.count 
    render json: { :orders_in_cart => orders_in_cart, status: :ok }
  end

end
