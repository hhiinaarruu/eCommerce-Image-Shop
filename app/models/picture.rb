class Picture < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_many :line_items
  paginates_per 50
  include Filterable

  mount_uploader :image, ImageUploader
  scope :author, -> (author) { where author: author }
  scope :finish, -> (finish) { where finish: finish }
  scope :condition, -> (condition) { where condition: condition }
  validates :title, :author, :price, :model, :image, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} character is the maximum aloud."}
  validates :title, length: { maximum: 140, too_long: "%{count} character is the maximum aloud."}
  validates :price, length: { maximum: 7 }
  AUTHOR = %w{ HiNaru Hinawabi Sakura Songoku Vandervial Madara Luffy Vegetar }
  FINISH = %w{ Silk Oil Colored-Mosaic Bronze Sand Paper }
  CONDITION = %w{ New Excellent Blur Torned Ancient }

  def self.search(params)
    pictures = Picture.where("title LIKE ? or condition LIKE ? or author LIKE ?",
              "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    pictures
  end

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end

  end
end
