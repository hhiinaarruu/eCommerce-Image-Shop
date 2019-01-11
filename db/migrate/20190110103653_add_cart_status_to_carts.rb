class AddCartStatusToCarts < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :cart_status, :integer, default: 0
  end
end
