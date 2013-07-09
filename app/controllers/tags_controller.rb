class TagsController < ApplicationController

  layout 'side_bar_layout'
  
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @cards = @tag.cards
  end

end
