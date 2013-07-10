class ChargesController < ApplicationController
  
  def new
  end

  def create
    customer = Stripe::Customer.create(
      :email => 'user@inkwell.com',
      :card => params[:stripeToken]
    )
    begin 
      charge = Stripe::Charge.create(
        :customer  => customer.id,
        :amount => params[:amount].to_i,
        :description => 'Inkwell customer',
        :currency  => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
    end
    if charge
      current_user.orders_in_cart.each do |order|
        order.status = "purchased"
        order.save
      end
      price = format_price(params[:amount].to_i)
      flash[:success] = "Your payment of #{price} went through successfully! Check out your delivery dates below!"
    end
      
    redirect_to occasions_path
  end

end
