class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true

  has_many :api_keys, dependent: :destroy

  has_secure_password
end
