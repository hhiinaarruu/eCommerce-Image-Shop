class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :author
      t.string :model
      t.text :description
      t.string :condition
      t.string :finish
      t.string :title
      t.decimal :price, precision: 5, scale: 2, default: 0

      t.timestamps
    end
  end
end
