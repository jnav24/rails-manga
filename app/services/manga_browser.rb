class MangaBrowser
  BASE_PATH = Rails.root.join('storage', 'mangas')

  def self.albums
    # Lists directories inside your base path
    Dir.glob("#{BASE_PATH}/*/").map { |path| File.basename(path) }
  end

  def self.images_in_album(album_name)
    # Lists image files inside a specific album
    Dir.glob("#{BASE_PATH}/#{album_name}/*.{jpg,jpeg,png,gif}")
       .map { |path| File.basename(path) }
  end
end