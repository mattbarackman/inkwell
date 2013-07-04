class FriendsController < ApplicationController

  before_filter :authenticate_user!

  def index
  end
  
  def new
    @friend = current_user.friends.new
  end

  def create
    friend = current_user.friends.build
    if friend.update_attributes(params[:friend])
      redirect_to friends_path
    else
      redirect_to user_root_path
    end
  end

  def edit
    @friend = Friend.find(params[:id])
    redirect_to user_root_path unless @friend.user == current_user
  end

  def update
    friend = Friend.find(params[:id])
    if friend.user == current_user && friend.update_attributes(params[:friend])
      redirect_to friends_path
    else
      redirect_to user_root_path
    end
  end

end
