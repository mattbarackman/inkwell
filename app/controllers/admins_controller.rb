class AdminsController < ApplicationController
  
  before_filter :authenticate_admin!

  def index
    @cards = Card.order("created_at DESC")
  end

end
