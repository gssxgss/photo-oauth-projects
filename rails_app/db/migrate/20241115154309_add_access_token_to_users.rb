class AddAccessTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :access_token, :string, comment: 'TweetAppp token'
    add_index :users, :access_token, unique: true
  end
end
