class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :user_id, null: false, comment: 'User ID'
      t.string :password_digest, null: false, comment: 'User Password Digest'

      t.timestamps
    end
    add_index :users, :user_id, unique: true
  end
end
