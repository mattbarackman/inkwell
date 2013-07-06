
class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update_attributes params[:card]
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    card = Card.find(params[:id])
    system("pwd")
    system("rm -rf app/assets/images/card_images/card_#{card.id}")
    card.destroy
    redirect_to admin_path
  end
end
