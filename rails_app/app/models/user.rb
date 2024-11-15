class User < ApplicationRecord
  has_many :photos, dependent: :destroy

  has_secure_password

  validates :user_id, presence: true, uniqueness: true
  validates :access_token, uniqueness: true, allow_blank: true

end
