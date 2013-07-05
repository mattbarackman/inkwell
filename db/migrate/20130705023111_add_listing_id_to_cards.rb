class AddListingIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :listing_id, :integer
  end
end
