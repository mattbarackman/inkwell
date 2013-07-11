class Order < ActiveRecord::Base
  attr_accessible :user_id, :occasion_id, :event_date

  belongs_to :user
  belongs_to :occasion
  belongs_to :card

  before_save :update_status

  def ajax_hash
    order_hash = { id: self.id,
                  card_id: self.card_id,
                  date: format_date(self.event_date),
                  friend: self.occasion.friend.name.titleize,
                  name: self.occasion.name.titleize
                  }

    order_hash[:friend_image_url] = self.occasion.friend.image_url if self.occasion.friend.image_url
    order_hash[:image_url] = self.card.photos.first.data.url(:medium) if self.card && self.card.photos.first.data.url(:medium)

    order_hash

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
    (event_date - Date.today).to_i < 60
  end

  def today?
    event_date == Date.today
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

  def format_date(date)
    day = date.day.ordinalize
    date.strftime("%B #{day}")
  end


end
