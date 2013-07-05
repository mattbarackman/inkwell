class CreateTags < ActiveRecord::Migration

  create_table :tags do |t|
    t.string :name, :null => false
    t.timestamps
  end 

end
