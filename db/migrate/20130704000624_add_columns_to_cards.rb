class AddColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :title, :string
    add_column :cards, :description, :text
    add_column :cards, :inventory, :integer
  end
end
