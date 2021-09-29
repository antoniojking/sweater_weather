require 'rails_helper'

RSpec.describe 'Sessions Api' do
  before :each do
    user1 = User.create!(email: 'whatever@example.com', password: '1234')
    user1.api_keys.create!(token: SecureRandom.hex)
  end

  describe 'happy path' do
    it 'logs in and returns an api key for an existing user' do
      user_params = {
        email: 'whatever@example.com',
        password: '1234'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user: user_params)
      current_user = User.last

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      data = json[:data]
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

  describe 'sad paths' do
    it 'incorrect username' do
      user_params = {
        email: 'what@example.com',
        password: '1234'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user: user_params)
      current_user = User.last

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Email/password are incorrect')
      expect(json).to have_key(:status)
    end

    it 'incorrect password' do
      user_params = {
        email: 'whatever@example.com',
        password: '12345'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user: user_params)
      current_user = User.last

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Email/password are incorrect')
      expect(json).to have_key(:status)
    end

    it 'blank username or password' do
      user_params = {
        email: '',
        password: '1234'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user: user_params)
      current_user = User.last

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Params must be specified')
      expect(json).to have_key(:status)
    end
  end
end
