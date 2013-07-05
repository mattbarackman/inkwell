class Authentication < ActiveRecord::Base

	attr_accessible :provider, :uid
	belongs_to :user

  def self.from_omniauth(omniauth)
    where(omniauth.slice(:provider, :uid)).first_or_create do |auth|
      auth.provider = omniauth.provider
      auth.uid = omniauth.uid
    end
  end

  def self.new_with_session(params, session)
    if session["devise.authentication_attributes"]
      new(session["devise.authentication_attributes"], without_protection: true) do |auth|
        auth.attributes = params
        auth.valid?
      end
    else
      super
    end
  end
end
