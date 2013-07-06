class Occasion < ActiveRecord::Base
  attr_accessible :date, :event_type_name, :name, :friend_id

  validates_presence_of :name, :date
  
  has_many :orders
  belongs_to :friend

  def user
    self.friend.user
  end

  def self.parse_birthday(birthday)
    /(\d{2})\/(\d{2})/.match(birthday)
    month = $1
    day = $2
    
    year = "2013"
    year = $1 if /(\d{4})/.match(birthday)

    date = "#{day}-#{month}-#{year}"      
    DateTime.parse(date)
  end
  
end
