class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.references :friend
      t.date :date
      t.string :name
      t.string :event_type_name

      t.timestamps
    end
    add_index :occasions, :friend_id
  end
end
