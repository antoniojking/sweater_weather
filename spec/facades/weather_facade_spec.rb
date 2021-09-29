require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods', :vcr do
    let(:location) { 'denver,co' }

    it '::forecast_by_coordinates' do
      forecast = WeatherFacade.forecast_by_city_state(location)
      expect(forecast).to be_a(Forecast)
    end

    it '::forecast_nearest_hour' do
      destination = 'Pueblo,CO'
      time = 6262
      forecast = WeatherFacade.forecast_nearest_hour(destination, time)
      expect(forecast).to be_an(HourlyWeather)
    end
  end
end
