class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true
end
