class AddStatusToCards < ActiveRecord::Migration
  def change
    add_column :cards, :status, :string, :default => "inactive"
  end
end
