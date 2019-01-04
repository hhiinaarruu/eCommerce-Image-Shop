class LineItem < ApplicationRecord
  belongs_to :picture
  belongs_to :cart
end
