class Occasion < ActiveRecord::Base
  attr_accessible :date, :event_type_name, :name, :friend_id

  validates_presence_of :name, :date
  
  has_many :orders
  belongs_to :friend

end
