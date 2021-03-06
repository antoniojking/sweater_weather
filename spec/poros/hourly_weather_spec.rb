require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exits', :vcr do
    coordinates = MapquestFacade.coordinates_by_city_state('denver,co')
    forecast = WeatherService.forecast_by_coordinates(coordinates)
    one_hour = HourlyWeather.new(forecast[:hourly][0])

    expect(one_hour).to be_an_instance_of(HourlyWeather)
    expect(one_hour.time).to eq(Time.at(forecast[:hourly][0][:dt]).strftime("%I:%M %p"))
    expect(one_hour.temperature).to eq(forecast[:hourly][0][:temp])
    expect(one_hour.conditions).to eq(forecast[:hourly][0][:weather][0][:description])
    expect(one_hour.icon).to eq(forecast[:hourly][0][:weather][0][:icon])
  end
end
