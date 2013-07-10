class AddYearToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :event_date, :date
  end
end
