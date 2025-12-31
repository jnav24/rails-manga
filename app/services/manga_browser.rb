class MangaBrowser
  BASE_PATH = Rails.root.join('storage', 'mangas')

  def self.albums(path = '')
    path = BASE_PATH.join(path)
    # Lists directories inside your base path
    Dir.glob("#{path}/*/").map { |path| File.basename(path) }
  end

  def self.images_in_album(album_name, path = '')
    path = BASE_PATH.join(path)
    # Lists image files inside a specific album
    files = Dir.glob("#{path}/#{album_name}/*.{jpg,jpeg,png,gif,webp}")
       .map { |path| File.basename(path) }

    # natural sort, aka natsort, images
    files.sort_by do |filename|
      filename.scan(/\d+/).first.to_i
    end
  end
end