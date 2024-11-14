class User < ApplicationRecord
  has_many :photos, dependent: :destroy

  has_secure_password

  validates :user_id, presence: true, uniqueness: true

end
