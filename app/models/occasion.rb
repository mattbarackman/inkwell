class Occasion < ActiveRecord::Base
  attr_accessible :date, :event_type_name, :name, :friend_id, :friend_name, :user_id, :annual

  validates_presence_of :name, :date

  has_many :orders
  belongs_to :friend

  #before_save :find_or_create_friend
  before_save :format_date
  after_save :create_order

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
    month = self.date.month
    day = self.date.day
    if Date.strptime("#{day}-#{month}-#{Date.today.year}", "%d-%m-%Y") < Date.today
      year = Date.today.year + 1
    else
      year = Date.today.year
    end
    order_date = Date.strptime("#{day}-#{month}-#{year}", "%d-%m-%Y")

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
    friend = Friend.find_or_create_by_name_and_user_id(params[:occasion][:friend_name], current_user.id)
    a = Friend.where("name = ? AND user_id = ?", friends_name, user_id)
    if a.empty?
      self.friend = Friend.create(:name => friends_name, :user_id => user_id)
    else
      self.friend = a[0]
    end
    self.friends_name = nil
    self.user_id = nil
  end

  def format_date
    Date.strptime(self.date, "%m/%d/%Y") if self.date.is_a?(String)
  end

end
