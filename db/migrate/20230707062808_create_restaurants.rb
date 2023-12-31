class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.time :open_time
      t.time :close_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
