class HomeController < ApplicationController
  def index
    @artworks = Artwork.all
    @users = User.all
  end
end
