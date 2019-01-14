class CheckoutNotifierMailer < ApplicationMailer
  default from: 'Painter website'

  def send_checkout_email(user)
    mail( to: user.email, subject: 'Thanks for checkout items for our amazing website' )
  end
end
