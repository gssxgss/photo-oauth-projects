class PhotosController < ApplicationController

  def index
    @photos = Photo.by_user_from_latest(current_user.id)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      flash[:success] = 'アップロード成功'
      redirect_to root_path
    else
      render :new, status: 400
    end
  end

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end
