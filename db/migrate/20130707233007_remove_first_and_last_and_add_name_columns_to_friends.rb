class RemoveFirstAndLastAndAddNameColumnsToFriends < ActiveRecord::Migration
  def change
    remove_column :friends, :first_name
    remove_column :friends, :last_name
    add_column :friends, :name, :string
  end

end
