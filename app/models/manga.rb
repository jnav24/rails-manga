class Manga < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :thumbnail, presence: true
  validates :banner, presence: true
  validates :poster, presence: true

  def chapters
    MangaBrowser.albums(location)
  end

  def chapter_images(chapter)
    MangaBrowser.images_in_album(chapter, location)
  end
end
