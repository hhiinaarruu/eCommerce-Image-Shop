class LineItem < ApplicationRecord
  belongs_to :picture
  belongs_to :cart

  def total_price
    picture.price.to_i * quantity.to_i
  end
end
