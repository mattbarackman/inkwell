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
    @card = Card.find(params[:card_id])
    @order.card = card
    if @order.save
      flash[:success] = "Thanks for picking a card!"
      redirect_to root_path
    else
      render :show
    end    
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to :back
  end
end
