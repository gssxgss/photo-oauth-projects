class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user
  helper_method :user_signed_in?
  # TODO remove authenticate_user
  before_action :authenticate_user
  
  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate_user
    flash.now[:fail] = 'ログインしてください'
    redirect_to login_path
  end
  
  def redirect_if_authenticated
    flash[:success] = 'すでにログインした'
    redirect_to root_path
  end

  def page_not_found
    render plain: '404 NOT FOUND'
  end
end
