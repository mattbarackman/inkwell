class FriendsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @friends = current_user.friends
  end
  
  def new
    @friend = current_user.friends.new
  end

  def create
    friend = current_user.friends.build
    try_to_update(friend, authorize_user: true)
  end

  def edit
    @friend = Friend.find(params[:id])
    redirect_to user_root_path unless @friend && @friend.user == current_user
  end

  def update
    friend = Friend.find(params[:id])
    try_to_update(friend, authorize_user: true)
  end

  def destroy
    Friend.delete(params[:id])
    redirect_to friends_path
  end

  def show_fb_friends
    @friends = current_user.get_facebook_friends
    render "facebook", layout: false
  end

  def add_fb_friend
    Friend.add_fb_friend(current_user, params)

    render :json => "hi there".to_json
  end




  private

  # See try_to_update in ApplicationController

#    def try_to_update(friend)
#      if friend && friend.user == current_user && friend.update_attributes(params[:friend])
#        redirect_to friends_path
#      else
#        redirect_to user_root_path
#      end
#    end

end
