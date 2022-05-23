class ArtworksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @artworks = Artwork.all
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.user_id = current_user.id
    if @artwork.save
      redirect_to artwork_path(@artwork), notice: '投稿に成功しました。'
    else 
      render :new
    end
  end

  def edit
    @artwork = Artwork.find(params[:id])
    if @artwork.user != current_user
      redirect_to artworks_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @artwork = Artwork.find(params[:id])
    if @artwork.update(artwork_params)
      redirect_to artwork_path(@artwork), notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    redirect_to artworks_path
  end

  private
  def artwork_params
    params.require(:artwork).permit(:title, :body, :image)
  end
end
