require 'rails_helper'

RSpec.describe 'Roadtrip Api' do
  before :each do
    user2 = User.create!(email: 'whatever@example.com', password: '1234')
    user2.api_keys.create!(token: SecureRandom.hex)
  end

  describe 'happy path' do

    it 'returns time to destination and forecast at time of arrival', :vcr do
      roadtrip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "#{User.last.api_keys.first.token}"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

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
      expect(attributes.keys.size).to eq(4)
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes).to have_key(:weather_at_eta)

      weather = attributes[:weather_at_eta]
      expect(weather).to be_a(Hash)
      expect(weather.keys.size).to eq(2)
      expect(weather).to have_key(:temperature)
      expect(weather[:temperature]).to be_a(Float)
      expect(weather).to have_key(:conditions)
      expect(weather[:conditions]).to be_a(String)
    end
  end

  describe 'sad paths' do
    it 'no api given', :vcr do
      roadtrip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: ""
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('An api key must be provided')
      expect(json).to have_key(:status)
    end

    it 'incorrect api given', :vcr do
      roadtrip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "jgn983hy48thw9begh98h4539h4"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('The api key provided is incorrect')
      expect(json).to have_key(:status)
    end

    it 'impossible route', :vcr do
      roadtrip_params = {
        origin: "Denver,CO",
        destination: "London,UK",
        api_key: "#{User.last.api_keys.first.token}"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

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
      expect(attributes.keys.size).to eq(4)
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes[:travel_time]).to eq('Impossible route')
      expect(attributes).to have_key(:weather_at_eta)

      weather = attributes[:weather_at_eta]
      expect(weather).to be_a(Hash)
      expect(weather.keys.size).to eq(2)
      expect(weather).to have_key(:temperature)
      expect(weather[:temperature]).to be_a(String)
      expect(weather[:temperature]).to eq('')
      expect(weather).to have_key(:conditions)
      expect(weather[:conditions]).to be_a(String)
      expect(weather[:conditions]).to eq('')
    end

    it 'missing params', :vcr do
      roadtrip_params = {
        origin: "",
        destination: "Pueblo,CO",
        api_key: "#{User.last.api_keys.first.token}"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(roadtrip_params)

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq('Params must be specified')
      expect(json).to have_key(:status)
    end
  end
end
