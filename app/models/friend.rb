class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :occasions

  attr_accessible :city, :name, :state, :street_address, :zipcode, :user_id

  validates_uniqueness_of :name, :scope => :user_id
  

  def self.add_fb_friend(current_user, params)
    existing_friend = Friend.find_by_name_and_user_id(params[:name], current_user.id)
    
    unless existing_friend
      friend = Friend.create(name: params[:name], user_id: current_user.id)
      friend.image_url = params[:image_url]
      if friend.save && params[:birthday].length > 1
        occasion = friend.occasions.build
        occasion.date = Occasion.parse_birthday(params[:birthday])
        occasion.name = "#{friend.name}'s Birthday!"
        occasion.event_type_name = 'birthday'
        occasion.annual = true
        occasion.save
      end
    end
  end
end
