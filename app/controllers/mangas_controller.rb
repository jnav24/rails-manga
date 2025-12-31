class MangasController < ApplicationController
  allow_unauthenticated_access

  def index
    @test = MangaBrowser.albums

    @mangas = Manga.all
  end

  def create
    @manga = Manga.new(manga_params)

    if @manga.save
      # redirect_to @password
      redirect_to mangas_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @manga = Manga.new
  end

  def show
    @manga = Manga.find(params[:id])
  end

  private

  def manga_params
    params.require(:manga).permit(:name, :description, :location, :thumbnail, :banner, :poster)
  end
end
