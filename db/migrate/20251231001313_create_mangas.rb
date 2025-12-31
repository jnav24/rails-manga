class CreateMangas < ActiveRecord::Migration[8.1]
  def change
    create_table :mangas do |t|
      t.string :name, null: false
      t.text :description
      t.string :location
      t.string :thumbnail
      t.string :banner
      t.string :poster
      t.timestamps
    end
  end
end
