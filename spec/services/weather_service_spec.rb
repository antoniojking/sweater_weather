require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    let(:location) { MapquestFacade.coordinates_by_city_state('denver,co') }

    it '::conn' do
      expect(WeatherService.conn).to be_a(Faraday::Connection)
    end

    it '::forecast_by_coordinates', :vcr do
      expect(WeatherService.forecast_by_coordinates(location)).to be_a(Hash)

      expect(WeatherService.forecast_by_coordinates(location)).to have_key(:current)
      expect(WeatherService.forecast_by_coordinates(location)[:current]).to be_a(Hash)
      expect(WeatherService.forecast_by_coordinates(location)[:current].keys.size).to eq(15)

      expect(WeatherService.forecast_by_coordinates(location)).to have_key(:hourly)
      expect(WeatherService.forecast_by_coordinates(location)[:hourly]).to be_an(Array)
      expect(WeatherService.forecast_by_coordinates(location)[:hourly].size).to eq(48)

      expect(WeatherService.forecast_by_coordinates(location)).to have_key(:daily)
      expect(WeatherService.forecast_by_coordinates(location)[:daily]).to be_an(Array)
      expect(WeatherService.forecast_by_coordinates(location)[:daily].size).to eq(8)

      expect(WeatherService.forecast_by_coordinates(location)).to_not have_key(:minutely)
      expect(WeatherService.forecast_by_coordinates(location)).to_not have_key(:alerts)
    end
  end
end
