class RemoveColumnFromRestaurants < ActiveRecord::Migration[7.0]
  def up
    remove_column :restaurants, :open_time
    remove_column :restaurants, :close_time
    remove_column :restaurants, :jwt_token
  end
  def down
    add_column :restaurants, :open_time, :time
    add_column :restaurants, :close_time, :time
  end
end
