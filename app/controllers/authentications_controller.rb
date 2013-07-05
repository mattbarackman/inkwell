class AuthenticationsController < ApplicationController

  def all
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.from_omniauth(omniauth)

    if authentication.persisted?
      authentication.user = User.find_or_create_by_email(omniauth.info.email)
      sign_in_and_redirect authentication.user
    else
      session["devise.authentication_attributes"] = authentication.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end