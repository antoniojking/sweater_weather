require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'happy path', :vcr do
    it 'returns forecast when given location params (city,state)' do
      get '/api/v1/forecast', params: { location: 'denver,co' }

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      forecast = json[:data]
      expect(forecast).to be_a(Hash)
      expect(forecast.keys.size).to eq(3)
      expect(forecast).to have_key(:id)
      expect(forecast[:id]).to be_a(String)
      expect(forecast).to have_key(:type)
      expect(forecast[:type]).to be_a(String)
      expect(forecast).to have_key(:attributes)

      attributes = forecast[:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes.keys.size).to eq(3)
      expect(attributes).to have_key(:current_weather)
      expect(attributes).to have_key(:daily_weather)
      expect(attributes).to have_key(:hourly_weather)

      current = attributes[:current_weather]
      expect(current).to be_a(Hash)
      expect(current.keys.size).to eq(10)
      expect(current).to have_key(:datetime)
      expect(current[:datetime]).to be_a(String)
      expect(current).to have_key(:sunrise)
      expect(current[:sunrise]).to be_a(String)
      expect(current).to have_key(:sunset)
      expect(current[:sunset]).to be_a(String)
      expect(current).to have_key(:temperature)
      expect(current[:temperature]).to be_a(Float)
      expect(current).to have_key(:feels_like)
      expect(current[:feels_like]).to be_a(Float)
      expect(current).to have_key(:humidity)
      expect(current[:humidity]).to be_a(Numeric)
      expect(current).to have_key(:uvi)
      expect(current[:uvi]).to be_a(Numeric)
      expect(current).to have_key(:visibility)
      expect(current[:visibility]).to be_a(Numeric)
      expect(current).to have_key(:conditions)
      expect(current[:conditions]).to be_a(String)
      expect(current).to have_key(:icon)
      expect(current[:icon]).to be_a(String)

      daily = attributes[:daily_weather]
      expect(daily).to be_an(Array)
      expect(daily.size).to eq(5)
      expect(daily[0]).to be_a(Hash)
      expect(daily[0].keys.size).to eq(7)
      expect(daily[0]).to have_key(:date)
      expect(daily[0][:date]).to be_a(String)
      expect(daily[0]).to have_key(:sunrise)
      expect(daily[0][:sunrise]).to be_a(String)
      expect(daily[0]).to have_key(:sunset)
      expect(daily[0][:sunset]).to be_a(String)
      expect(daily[0]).to have_key(:max_temp)
      expect(daily[0][:max_temp]).to be_a(Float)
      expect(daily[0]).to have_key(:min_temp)
      expect(daily[0][:min_temp]).to be_a(Float)
      expect(daily[0]).to have_key(:conditions)
      expect(daily[0][:conditions]).to be_a(String)
      expect(daily[0]).to have_key(:icon)
      expect(daily[0][:icon]).to be_a(String)

      hourly = attributes[:hourly_weather]
      expect(hourly).to be_an(Array)
      expect(hourly.size).to eq(8)
      expect(hourly[0]).to be_a(Hash)
      expect(hourly[0].keys.size).to eq(4)
      expect(hourly[0]).to have_key(:time)
      expect(hourly[0][:time]).to be_a(String)
      expect(hourly[0]).to have_key(:temperature)
      expect(hourly[0][:temperature]).to be_a(Float)
      expect(hourly[0]).to have_key(:conditions)
      expect(hourly[0][:conditions]).to be_a(String)
      expect(hourly[0]).to have_key(:icon)
      expect(hourly[0][:icon]).to be_a(String)
    end
  end

  describe 'sad path', :vcr do
    it 'will not return forecast without location params' do
      get '/api/v1/forecast'

      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
      expect(error).to have_key(:status)
    end

    it 'will not return forecast with blank location' do
      get '/api/v1/forecast', params: { location: '' }

      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:message)
      expect(error).to have_key(:status)
    end

    it 'will render an error message when location is invalid or does not exist' do
      get '/api/v1/forecast', params: { location: 'adjkijfp' }

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      forecast = json[:data]
      expect(forecast).to be_a(Hash)
      expect(forecast.keys.size).to eq(3)
      expect(forecast).to have_key(:id)
      expect(forecast[:id]).to be_a(String)
      expect(forecast).to have_key(:type)
      expect(forecast[:type]).to be_a(String)
      expect(forecast).to have_key(:attributes)
    end
  end
end
