class AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def cards
    @cards = Card.order("created_at DESC")
  end

  def orders
    @orders_to_ship_today = Order.shipping_today
    # move these to named methods on the model
    @orders_to_ship_this_week = Order.with_card.select{|order| order.ship_this_week?}.sort_by{|order| order.fulfillment_date}
    @orders_to_ship_later = Order.with_card.select{|order| order.ship_in_future?}.sort_by{|order| order.fulfillment_date}
    @statuses = ["no_card", "in_cart", "purchased", "fulfilled"]
  end

end
