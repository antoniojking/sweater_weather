require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exits', :vcr do
    coordinates = MapquestFacade.coordinates_by_city_state('denver,co')
    forecast = WeatherService.forecast_by_coordinates(coordinates)
    current = CurrentWeather.new(forecast[:current])

    expect(current).to be_an_instance_of(CurrentWeather)
    expect(current.datetime).to eq(Time.at(forecast[:current][:dt]).strftime("%B %e, %Y at %I:%M %p"))
    expect(current.sunrise).to eq(Time.at(forecast[:current][:sunrise]).strftime("%B %e, %Y at %I:%M %p"))
    expect(current.sunset).to eq(Time.at(forecast[:current][:sunset]).strftime("%B %e, %Y at %I:%M %p"))
    expect(current.temperature).to eq(forecast[:current][:temp])
    expect(current.feels_like).to eq(forecast[:current][:feels_like])
    expect(current.humidity).to eq(forecast[:current][:humidity])
    expect(current.uvi).to eq(forecast[:current][:uvi])
    expect(current.visibility).to eq(forecast[:current][:visibility])
    expect(current.conditions).to eq(forecast[:current][:weather][0][:description])
    expect(current.icon).to eq(forecast[:current][:weather][0][:icon])
  end
end
