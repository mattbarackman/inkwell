class AddAnnualEvents < ActiveRecord::Migration
  def up
    add_column :occasions, :annual, :boolean
  end

  def down
    remove_column :occasions, :annual
  end
end
