class PhotosController < ApplicationController
  
  def destroy
    Photo.find(params[:id]).destroy
    redirect_to :back
  end

end
