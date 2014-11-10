class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :authenticate

  include SessionsHelper

  private

  def authenticate
    unless Rails.env.test?
      authenticate_or_request_with_http_basic {|username, password| username == 'codev' && password == "kcc"}
    end
  end
end
