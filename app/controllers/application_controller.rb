class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # http basic auth below to control early preview
  # before_action :authenticate
  # def authenticate
  #   authenticate_or_request_with_http_basic('Administration') do |username, password|
  #     username == '' && password == ''
  #   end
  # end

end
