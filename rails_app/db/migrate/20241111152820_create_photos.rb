class CreatePhotos < ActiveRecord::Migration[7.2]
  def change
    create_table :photos do |t|
      t.string :title, null: false, comment: 'photo title'
      t.string :image, null: false, comment: 'photo image file'
      t.references :user, foreign_key: true, comment: 'user foreign_key'
      t.timestamps
    end
  end
end
