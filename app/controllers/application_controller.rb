class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  private
  
  def logged_in_user
    unless logged_in?
      redirect_to login_path
    end
  end

  def app_password
    "password1234"
  end
end
