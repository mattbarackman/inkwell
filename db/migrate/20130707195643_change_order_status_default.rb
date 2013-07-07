class ChangeOrderStatusDefault < ActiveRecord::Migration
  def change
    change_column_default(:orders, :status, "no_card")
  end
end
