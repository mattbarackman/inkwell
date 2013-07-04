class Occasion < ActiveRecord::Base
  belongs_to :friend
  attr_accessible :date, :event_type_name, :name, :friend_id

  validates :name, :date, :presence => true
end
