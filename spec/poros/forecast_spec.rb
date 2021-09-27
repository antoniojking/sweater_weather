require 'rails_helper'

RSpec.describe Forecast do
  it 'exits', :vcr do
    location = MapquestFacade.coordinates_by_city_state('denver,co')
    json = WeatherService.forecast_by_coordinates(location)
    current = json[:current]
    hourly = json[:hourly]
    daily = json[:daily]
    forecast = Forecast.new(current, hourly, daily)

    expect(forecast).to be_a(Forecast)
    expect(forecast.id).to eq('null')
    expect(forecast.current_weather).to be_a(CurrentWeather)

    expect(forecast.daily_weather).to be_an(Array)
    forecast.daily_weather.each do |day|
      expect(day).to be_a(DailyWeather)
    end

    expect(forecast.hourly_weather).to be_an(Array)
    forecast.hourly_weather.each do |hour|
      expect(hour).to be_a(HourlyWeather)
    end
  end
end
