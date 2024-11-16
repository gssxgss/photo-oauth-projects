class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    errors = []
    errors.push 'ユーザーIDを入力してください。' unless params[:user_id].present?
    errors.push 'パスワードを入力してください。' unless params[:password].present?
    if errors.present?
      flash.now[:alert] = errors.join()
      render :new, status: 401
      return
    end

    user = User.find_by(user_id: params[:user_id])
    if user.present? && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = 'ログイン成功'
      redirect_to root_path
    else
      flash.now[:alert] = 'ログイン失敗'
      render :new, status: 401
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウト成功'
    redirect_to login_path
  end
end

# NOTE
# ref: https://stackoverflow.com/questions/71981471/why-is-my-flash-now-not-outputting-after-a-render
# flash.now[:alert] needs status != 200
