class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
  end

  def login
    log_out
    @password = ""
  end

  def login_post
    entered_password = params[:password]

    if entered_password == app_password
      log_in
      redirect_to root_path
    else
      flash[:failure] = "Wrong password!"
      redirect_to login_path
    end
  end
end
