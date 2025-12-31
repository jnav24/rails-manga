class Manga < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :thumbnail, presence: true
  validates :banner, presence: true
  validates :poster, presence: true
end
