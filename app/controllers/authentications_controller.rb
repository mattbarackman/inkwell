class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    
    authentication = Authentication.find_by_provider_and_uid(omniauth.provider, omniauth.uid)
    
    if authentication
      sign_in_and_redirect authentication.user
    elsif current_user
      current_user.authentications.create!(:provider => omniauth.provider, :uid => omniauth.uid)
      redirect_to '/profile'
    else
      user = User.find_by_email(omniauth.info.email)
      if omniauth.provider == 'google_oauth2' && user
        sign_in_and_redirect user
      else
        user = User.new
        user.apply_omniauth(omniauth)
        if user.save
          sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url
  end

  protected
  
  def handle_unverified_request
    true
  end

end