class CreateOrders < ActiveRecord::Migration
 def change
  create_table :orders do |t|
    t.references :user, null: false
    t.references :occasion, null: false
    t.references :card
    t.integer :lead_time, :default => 604800
    t.string :status, :default => "in_cart"
  end

  add_index :orders, :user_id
 end
end
