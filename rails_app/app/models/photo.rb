class Photo < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: {maximum: 30}
  validates :image, presence: true

  scope :by_user_from_latest, -> (user_id) {
    where(user_id: user_id).order(created_at: :desc)
  }

  def image_url
    self.image.try(:url)
  end
end
