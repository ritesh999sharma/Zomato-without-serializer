class AddReferenceToCarts < ActiveRecord::Migration[7.0]
  def change
    add_reference :dishes, :cart
  end
end
