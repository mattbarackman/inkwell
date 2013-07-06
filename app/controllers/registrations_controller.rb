class RegistrationsController < Devise::RegistrationsController

  def failure
    super
  end
  # def create
  #   super
  #   session[:omniauth] = nil unless @user.new_record?
  # end
  
  # private
  
  # def build_resource(*args)
  #   super
  #   if session[:omniauth]
  #     @user.apply_omniauth(session[:omniauth])
  #     @user.valid?
  #   end
  # end

  protected

  def after_sign_in_path_for(resource)
    user_path(resource)
  end


end