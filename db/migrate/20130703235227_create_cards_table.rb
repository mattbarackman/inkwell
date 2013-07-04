class CreateCardsTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :price
      t.string :company_name
      t.string :company_city
      t.string :company_url

      t.timestamps
    end
  end
end
