class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :card
      t.string :file_location

      t.timestamps
    end
  end
end
