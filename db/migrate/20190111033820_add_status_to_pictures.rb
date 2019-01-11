class AddStatusToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :status, :integer, default: 1;
  end
end
