class PhotosController < ApplicationController
  
  def destroy
    Photo.find(params[:id]).destroy
    render :nothing => true, :status => :ok
  end

end
