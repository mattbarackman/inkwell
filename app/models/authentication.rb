class Authentication < ActiveRecord::Base

	attr_accessible :provider, :uid
	belongs_to :user

  def self.from_omniauth(omniauth)
    where(omniauth.slice(:provider, :uid)).first_or_create do |auth|
      auth.provider = omniauth.provider
      auth.uid = omniauth.uid
      auth.oauth_token = omniauth.credentials.token
      auth.oauth_expires_at = Time.at(omniauth.credentials.expires_at)
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |auth|
        auth.attributes = params
        auth.valid?
      end
    else
      super
    end
  end
end
