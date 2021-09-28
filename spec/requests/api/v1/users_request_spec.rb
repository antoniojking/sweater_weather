require 'rails_helper'

RSpec.describe 'Users Api' do
  describe 'happy path' do
    it 'creates a user and generates a unique api key for that user' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/users', headers: headers, body: JSON.generate(user_params) #send a JSON payload in the body of the request
      created_user = User.last

      expect(response.status).to eq(201)

      expect(created_user.email).to eq(user_params[:email])
      expect(created_user.api_key).to eq(user_params[:api_key])

      data = JSON.parse(response.body, symbolize_names: true)

      data = created_user[:data]
      expect(data).to be_a(Hash)
      expect(data.keys.size).to eq(3)
      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data).to have_key(:attributes)

      attributes = data[:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes.keys.size).to eq(2)
      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a(String)
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
      end
    end
  end
end
