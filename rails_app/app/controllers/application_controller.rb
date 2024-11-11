class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  include SessionsHelper

  # TODO remove authenticate_user
  before_action :authenticate_user
  
  def authenticate_user
    unless logged_in?
      flash.now[:fail] = 'ログインしてください'
      redirect_to login_path
    end
  end
  
  def redirect_if_authenticated
    if logged_in?
      flash[:success] = 'すでにログインした'
      redirect_to root_path
    end
  end

  def page_not_found
    render plain: '404 NOT FOUND'
  end
end
