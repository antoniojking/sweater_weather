require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods', :vcr do
    let(:location) { MapquestFacade.coordinates_by_city_state('denver,co') }

    it '::forecast_by_coordinates' do
      forecast = WeatherFacade.forecast_by_city_state(location)
      expect(forecast).to be_a(Forecast)
    end
  end
end
