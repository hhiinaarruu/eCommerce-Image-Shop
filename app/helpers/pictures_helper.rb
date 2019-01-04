module PicturesHelper
  def picture_author(picture)
    user_signed_in? && current_user.id == picture.user_id
  end
end
