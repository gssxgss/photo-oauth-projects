class AddLimitToPhotosTitle < ActiveRecord::Migration[7.2]
  def change
    change_column :photos, :title, :string, limit: 30
  end
end
