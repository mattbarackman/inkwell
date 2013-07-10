class Occasion < ActiveRecord::Base
  attr_accessible :date, :event_type_name, :name, :friend_id, :friend_name, :user_id, :annual

  attr_accessor :user_id, :friend_name

  validates_presence_of :name, :date
  
  has_many :orders
  belongs_to :friend

  before_save :find_or_create_friend
  after_save :create_order

  def user
    self.friend.user
  end

  def self.parse_birthday(birthday)
    /(\d{2})\/(\d{2})/.match(birthday)
    month = $1
    day = $2
    date = "#{day}-#{month}"      
    Date.strptime(date, "%d-%m")
  end
  
  def create_order
    month = self.date.month
    day = self.date.day
    order_date = Date.strptime("#{day}-#{month}-#{Date.today.year}", "%d-%m-%Y")
    if order_date < Date.today
      order_date += 1.year
    end
    Order.create(occasion_id: id, user_id: friend.user.id,
                 event_date: order_date)
  end

  def upcoming?
    (date - Date.today).to_i < 60
  end
  
  def today?
    date == Date.today
  end

  private
  
  def find_or_create_friend
    unless self.friend
      a = Friend.where("name = ? AND user_id = ?", friend_name, user_id)
      if a.empty?
        self.friend = Friend.create(:name => friend_name, :user_id => user_id)
      else
        self.friend = a[0]
      end
      self.friend_name = nil
      self.user_id = nil
    end
  end

end
