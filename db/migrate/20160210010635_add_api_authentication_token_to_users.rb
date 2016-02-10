class AddApiAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_authentication_token, :string
  end
end
