class Order < ActiveRecord::Base
  attr_accessible :user_id, :occasion_id

  belongs_to :user
  belongs_to :occasion
  belongs_to :card

  before_save :update_status

  def update_status
    self.status = "in_cart" if status == "no_card" && card
  end

end
