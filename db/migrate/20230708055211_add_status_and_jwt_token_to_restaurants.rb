class AddStatusAndJwtTokenToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :status, :string
    add_column :restaurants, :jwt_token, :string
    add_index :restaurants, :jwt_token
  end
end
