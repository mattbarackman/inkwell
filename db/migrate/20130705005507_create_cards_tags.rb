class CreateCardsTags < ActiveRecord::Migration
  def change

    create_table :cards_tags do |t|
      t.references :card
      t.references :tag
    end

  add_index :cards_tags, :card_id
  add_index :cards_tags, :tag_id
  
  end
end
