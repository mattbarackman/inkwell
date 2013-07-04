class OccasionsController < ApplicationController

	before_filter :authenticate_user!

	def new
		@occasion = Occasion.new
	end

	def create
		occasion = Occasion.new

		if occasion.update_attributes(params[:occasion])
			redirect_to '/occasions'
		else
			redirect_to '/occasions/new'
		end		
	end

end