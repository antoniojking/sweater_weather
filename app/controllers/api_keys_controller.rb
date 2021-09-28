class ApiKeysController < ApplicationController
  include ApiKeyAuthenticatable

  prepend_before_action :authenticate_with_api_key!, only: [:index]

  def index
    render(json: current_user.api_keys)
  end

  def create
    authenticate_with_http_token do |email, password|
      user = User.find_by(email: email)

      if user&.authenticate(password)
        appi_key = user.api_keys.create!(token: SecureRandom.hex)

        render(json: api_key, status: :created and return)
      end
    end

    render(status: :unauthorized)
  end
end
