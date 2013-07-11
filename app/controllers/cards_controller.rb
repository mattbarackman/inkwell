class CardsController < ApplicationController

  layout 'side_bar_layout', :except => [:show]

  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update_attributes params[:card]
      render :nothing => true, :status => :ok
    else
      redirect_to :back
    end
  end

  def destroy
    card = Card.find(params[:id])
    card.destroy
    render :nothing => true, :status => :ok
  end
end
