class CheckoutNotifierMailer < ApplicationMailer
  default from: 'railscasts@gmail.com'

  def send_checkout_email(user)
    mail( to: user.email, subject: 'Thanks for checkout items for our amazing website' )
  end
end
