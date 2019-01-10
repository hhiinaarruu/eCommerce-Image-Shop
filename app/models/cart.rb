class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_picture(picture)
    current_item = line_items.find_by(picture_id: picture.id)
    if current_item
      current_item.increment(:quantity)
    else
      current_item = line_items.build(picture_id: picture.id)
    end
    current_item
  end
end
