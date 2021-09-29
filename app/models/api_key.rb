class ApiKey < ApplicationRecord
  validates :token, presence: true

  belongs_to :user

  # has_secure_token
end
