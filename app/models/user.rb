class User < ActiveRecord::Base
  has_many :authentications
  has_many :friends
  has_many :orders  
  has_many :occasions, :through => :friends
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :street_address, :city, :state,
  :zipcode, :provider, :uid, :name

  after_create :send_welcome_email

  # please do not uncomment line below, devise validates appropriate fields
  # and having the below validations makes omniauth fb/twitter logins not work
  # validates_presence_of :first_name, :last_name, :email, :encrypted_password


  def password_required?
    (authentications.empty? || password.blank?) && super
  end

  def name
    first_name + " " + last_name
  end

  def occasions_without_cards
    orders.select{|order| order.card == nil}.map{|order| order.occasion}
  end

  def facebook
    oauth_token = self.authentications.find_by_provider('facebook').oauth_token
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
    nil # or consider a custom null object
  end

  def get_facebook_friends
    friends = facebook.get_connections("me", "friends", "fields"=>"name,birthday")
    friends.sort{|a,b| a['name'] <=> b['name']}
  end

  def logged_in_with_facebook?
    self.authentications.find_by_provider('facebook')
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
