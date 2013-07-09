class AddImageUrlColumnToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :image_url, :string
  end
end
