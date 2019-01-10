class ApplicationController < ActionController::Base
  include CurrentCart
  protect_from_forgery with: :exception
end
