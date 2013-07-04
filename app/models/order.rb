class Order < ActiveRecord::Base
  attr_accessible :user_id, :occasion_id

  belongs_to :user
  belongs_to :occasion
  belongs_to :card

end