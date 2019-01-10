class PictureNotifierMailer < ApplicationMailer
  default :from => 'railscasts@gmail.com'

  def send_picture_notifier_email(user)
    mail( :to => user.email,
    :subject => 'A new picture items update for our amazing website' )
  end
end
