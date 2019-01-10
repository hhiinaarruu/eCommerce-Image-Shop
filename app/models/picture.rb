class Picture < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_many :line_items

  mount_uploader :image, ImageUploader

  validates :title, :author, :price, :model, :image, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} character is the maximum aloud."}
  validates :title, length: { maximum: 140, too_long: "%{count} character is the maximum aloud."}
  validates :price, length: { maximum: 7 }
  AUTHOR = %w{ HiNaru Hinawabi Sakura Songoku Vandervial Madara Luffy Vegetar }
  FINISH = %w{ Silk Oil Colored-Mosaic Bronze Sand Paper }
  CONDITION = %w{ New Excellent Blur Torned Ancient }

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end

  end
end
