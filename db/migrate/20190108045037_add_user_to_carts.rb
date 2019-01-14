class AddUserToCarts < ActiveRecord::Migration[5.0]
  def change
    add_reference :carts, :user, foreign_key: true
  end
end
