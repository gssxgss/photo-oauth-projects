class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authentication_user
  end
  
  def redirect_if_authenticated
  end

  def page_not_found
    render plain: '404 NOT FOUND'
  end
end
