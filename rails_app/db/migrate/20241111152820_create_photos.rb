class CreatePhotos < ActiveRecord::Migration[7.2]
  def change
    create_table :photos do |t|
      t.string :title, null: false
      t.string :image, null: false 
      t.references :user, foreign_key: true, comment: 'user foreign_key'
      t.timestamps
    end
  end
end
