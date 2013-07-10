class Order < ActiveRecord::Base
  attr_accessible :user_id, :occasion_id, :event_date

  belongs_to :user
  belongs_to :occasion
  belongs_to :card

  before_save :update_status
  before_save :update_card

  STATUSES = {
    :no_card => 'no_card',
    :purchased => 'purchased',
    :in_cart => 'in_cart',
    :fulfilled => 'fulfilled'
  }

  STATUSES.keys.each do |stat|
    define_method "#{stat}?" do
      self.status == STATUSES[stat]
    end
    define_method "#{stat}!" do
      self.update_attributes :status => STATUSES[stat]
    end
  end

  def ajax_hash
    order_hash = { id: self.id,
                  card_id: self.card_id,
                  date: self.event_date,
                  friend: self.occasion.friend.name.titleize,
                  name: self.occasion.name.titleize
                  }

    order_hash[:image_url] = self.card.photos.first.data.url(:medium) if self.card && self.card.photos.first.data.url(:medium)

    order_hash

  end

  FULLFILLMENT_TRANSIT_TIME = 432000 # 5 Days

  scope :with_card, where("status != 'no_card'")

  def self.shipping_today
    self.with_card.select{|order| order.ship_today?}.sort_by{|order| order.fulfillment_date}
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

  private
  def update_status
    self.status = "in_cart" if no_card? && card
  end

  def update_card
    order.card = nil if self.no_card?
  end

end
