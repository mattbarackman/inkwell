class Card < ActiveRecord::Base
 attr_accessible :price, :company_name, :company_city, :company_url, :title, :description, :inventory, :listing_id, :cards_tags_attributes

 # belongs_to :order
 # has_many_and_belongs_to :tags

 validates_presence_of :price, :title, :description, :inventory
 has_many :orders
 has_many :photos
 
 has_many :cards_tags
 has_many :tags, :through => :cards_tags

 accepts_nested_attributes_for :cards_tags

 def tag_names
  tags.map{|tag| tag.name}.join(", ")
 end

end
