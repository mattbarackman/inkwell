class CardsTag < ActiveRecord::Base
  attr_accessible :tag_id
  belongs_to :card
  belongs_to :tag

  validates_uniqueness_of :tag_id, :scope => :card_id

end
