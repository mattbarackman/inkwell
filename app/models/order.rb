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

  FULLFILLMENT_TRANSIT_TIME = 432000 # 5 Days

  scope :with_card, where("status != 'no_card'")

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

  # For Admin Tools

  def fulfillment_date
    (occasion.date.to_time - lead_time - FULLFILLMENT_TRANSIT_TIME ).to_date
  end

  def ship_today?
    fulfillment_date == Date.today
  end

  def ship_this_week?
    fulfillment_date > Date.today && fulfillment_date <= Date.today + 7.days
  end

  def ship_in_future?
    fulfillment_date > Date.today + 7.days
  end

end
