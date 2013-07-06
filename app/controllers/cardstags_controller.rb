class CardstagsController < ApplicationController

  def destroy
    card = Card.find(params[:card])
    tag = Tag.find(params[:tag])
    card.tags.delete(tag)
    redirect_to :back
  end

end
