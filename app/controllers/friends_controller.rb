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
			redirect_to '/friends'
		else
			redirect_to '/profile'
		end
	end



end