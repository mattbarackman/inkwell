class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :occasions

  attr_accessible :city, :first_name, :last_name, :state, :street_address, :zipcode

  validates_presence_of :first_name, :last_name

end
