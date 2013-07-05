class Card < ActiveRecord::Base
 attr_accessible :price, :company_name, :company_city, :company_url, :title, :description, :inventory, :listing_id

 # belongs_to :order
 # has_many_and_belongs_to :tags

 validates_presence_of :price, :title, :description, :inventory
 has_many :orders
 has_many :photos
 has_and_belongs_to_many :tags

end
