class Picture < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_many :line_items
  paginates_per 50
  enum status: %i[unavailable available]
  include Filterable
  mount_uploader :image, ImageUploader
  scope :author, -> (author) { where author: author }
  scope :finish, -> (finish) { where finish: finish }
  scope :condition, -> (condition) { where condition: condition }
  validates :title, :author, :price, :model, presence: true
  validates :description, length:  { minimum: 3, maximum: 1000 }
  validates :title, length:  { minimum: 3, maximum: 15 }
  # validates :price, length: { minimum: 2, maximum: 7 }
  AUTHOR = %w{ HiNaru Hinawabi Sakura Songoku Vandervial Madara Luffy Vegetar }
  FINISH = %w{ Silk Oil ColoredMosaic Bronze Sand Paper }
  CONDITION = %w{ New Excellent Blur Torned Ancient }
  class << self
    def search(params)
      pictures = Picture.where("title LIKE ? or condition LIKE ? or author LIKE ?",
              "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
      pictures
    end
  end
  private
  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end
end
