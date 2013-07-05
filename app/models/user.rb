class User < ActiveRecord::Base
  has_many :authentications
  has_many :friends
  has_many :orders  
  has_many :occasions, :through => :friends
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :street_address, :city, :state,
  :zipcode, :provider, :uid, :name



  # please do not uncomment line below, devise validates appropriate fields
  # and having the below validations makes omniauth fb/twitter logins not work
  # validates_presence_of :first_name, :last_name, :email, :encrypted_password

  def apply_omniauth(omniauth)
    self.email = omniauth.info.email if email.blank?
    authentications.build(:provider => omniauth.provider, :uid => omniauth.uid)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.first_name = auth.info.first_name
  #     user.last_name = auth.info.last_name
  #   end
  # end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # def password_required?
  #   super && provider.blank?
  # end

  def name
    first_name + " " + last_name
  end


  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
