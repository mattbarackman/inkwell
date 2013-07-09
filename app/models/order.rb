class Order < ActiveRecord::Base
  attr_accessible :user_id, :occasion_id

  belongs_to :user
  belongs_to :occasion
  belongs_to :card

  before_save :update_status

  def ajax_hash
    { id: self.id,
      card_id: self.card_id,
      date: self.occasion.date,
      friend: self.occasion.friend.name.titleize,
      name: self.occasion.name.titleize }
  end

  def update_status
    self.status = "in_cart" if status == "no_card" && card
  end

  def delivery_date
    (occasion.date.to_time - lead_time).to_date
  end

  def upcoming?
    occasion.upcoming?
  end

  def today?
    occasion.today?
  end

end
