class AddColumnToPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :file_location
    add_attachment :photos, :data
  end
end
