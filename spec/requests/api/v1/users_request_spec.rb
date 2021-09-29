require 'rails_helper'

RSpec.describe 'Users Api' do
  describe 'happy path' do
    it 'creates a user and generates a unique api key for that user' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)
      created_user = User.last

      expect(response.status).to eq(201)

      expect(created_user.email).to eq(user_params[:email])
      expect(created_user.api_keys.first).to eq(ApiKey.last)

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
    it 'passwords dont match' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'pasword'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Password inputs dont match')
      expect(json).to have_key(:status)
    end

    it 'email already exists' do
      User.create!(email: 'whatever@example.com', password: '1234', password_confirmation: '1234')

      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Email already exists')
      expect(json).to have_key(:status)
    end

    it 'email cannot be blank' do
      user_params = {
        email: ' ',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Invalid json request')
      expect(json).to have_key(:status)
    end

    it 'password cannot be blank' do
      user_params = {
        email: ' ',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Invalid json request')
      expect(json).to have_key(:status)
    end
  end
end
