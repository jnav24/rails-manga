class MangasController < ApplicationController
  allow_unauthenticated_access

  def index
    @test = MangaBrowser.albums

    @mangas = Manga.all.order(name: :asc)
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

  def edit
    @manga = Manga.find(params[:id])
  end

  def update
    @manga = Manga.find(params[:id])
    if @manga.update(manga_params)
      redirect_to @manga, notice: 'Manga was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @manga = Manga.find(params[:id])
    # @manga.destroy
    redirect_to mangas_path
  end

  def chapter
    @manga = Manga.find(params[:id])
    @chapter = params[:chapter]
    @images = MangaBrowser.images_in_album(@chapter, @manga.location)
  end

  def image
    location = params[:location]
    chapter = params[:chapter]
    image_name  = params[:format].present? ? "#{params[:image_name]}.#{params[:format]}" : params[:image_name]
    file_path = Rails.root.join('storage', 'mangas', location, chapter, image_name)

    if File.exist?(file_path)
      send_file file_path, disposition: 'inline'
    else
      Rails.logger.error "File not found at: #{file_path}"
      head :not_found

    end
  end

  private

  def manga_params
    params.require(:manga).permit(:name, :description, :location, :thumbnail, :banner, :poster)
  end
end
