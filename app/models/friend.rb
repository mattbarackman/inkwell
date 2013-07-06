class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :occasions

  attr_accessible :city, :first_name, :last_name, :state, :street_address, :zipcode

  validates_presence_of :first_name#, :last_name

  def name
    first_name + " " + last_name
  end

  
  def self.add_fb_friend(current_user, params)
    friend = current_user.friends.build
    friend.first_name = params[:name]
    friend.save

    if params[:birthday].length > 1
      occasion = friend.occasions.build
      occasion.date = Occasion.parse_birthday(params[:birthday])
      occasion.name = 'Birthday'
      occasion.event_type_name = 'Birthday'
      occasion.save
    end
  end



end
