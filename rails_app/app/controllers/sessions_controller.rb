class SessionsController < ApplicationController
  # skip_before_action :authenticate_user, only: [:new, :create]
  # before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_id: params[:user][:user_id])
    if @user.present? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = 'ログイン成功'
      redirect_to root_path
    else
      flash.now[:danger] = 'ログイン失敗'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウト成功'
    redirect_to new_users_path
  end
end
