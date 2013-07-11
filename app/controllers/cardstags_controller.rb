class CardstagsController < ApplicationController

  def destroy
    card = Card.find(params[:card])
    tag = Tag.find_by_name(params[:tag])
    card.tags.delete(tag)
    render :nothing => true, :status => :ok
  end

end
