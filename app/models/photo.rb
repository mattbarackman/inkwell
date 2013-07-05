class Photo < ActiveRecord::Base
  attr_accessible :file_location
  belongs_to :card
end
