require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    let(:location) { 'denver,co' }

    it '::forecast_by_coordinates', :vcr do
      forecast = WeatherFacade.forecast_by_city_state(location)
      expect(forecast).to be_a(Forecast)
    end
  end
end
