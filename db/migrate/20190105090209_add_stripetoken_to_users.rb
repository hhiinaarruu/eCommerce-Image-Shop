class AddStripetokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_token, :string
  end
end
