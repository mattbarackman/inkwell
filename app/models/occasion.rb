class Occasion < ActiveRecord::Base
  attr_accessible :date, :event_type_name, :name, :friend_id, :friend_name

  validates_presence_of :name, :date
  
  has_many :orders
  belongs_to :friend

  #before_create :find_or_create_friend
  after_create :create_order

  def user
    self.friend.user
  end

  def friend_name
    friend.try(:name)
  end

  def friend_name=(name)
    self.friend = Friend.find_or_create_by_name(name) if name.present?
  end

  def self.parse_birthday(birthday)
    /(\d{2})\/(\d{2})/.match(birthday)
    month = $1
    day = $2
    date = "#{day}-#{month}"      
    Date.strptime(date, "%d-%m")
  end
  
  def create_order
    Order.create(occasion_id: id, user_id: friend.user.id )
  end

  def upcoming?
    (date - Date.today).to_i < 60
  end
  
  def today?
    date == Date.today
  end

  private
  
  # def find_or_create_friend
  #   self.friend = Friend.find_or_create_by_name(name)
  # end

end
