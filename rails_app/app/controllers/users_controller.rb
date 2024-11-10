class UsersController < ApplicationController
  # skip_before_action :authenticate_user, only: [:new, :create]
  # before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, flash: {success: '登録成功'}
    else
      flash.now[:danger] = '登録失敗'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :password, :password_confirmation)
  end
end
