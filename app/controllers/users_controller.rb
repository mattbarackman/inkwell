class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def profile
  end

  def checkout
  end

end
