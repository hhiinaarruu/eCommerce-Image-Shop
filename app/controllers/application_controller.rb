class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  include CurrentCart
  protect_from_forgery with: :exception
end
