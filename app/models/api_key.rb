class ApiKey < ApplicationRecord
  validates_presence_of :token

  belongs_to :user

  # has_secure_token
end
