class RemoveAccessTokenFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_index :users, :access_token
    remove_column :users, :access_token, :string
  end
end
