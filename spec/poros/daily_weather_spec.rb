require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exits', :vcr do
    coordinates = MapquestFacade.coordinates_by_city_state('denver,co')
    forecast = WeatherService.forecast_by_coordinates(coordinates)
    one_day = DailyWeather.new(forecast[:daily][0])

    expect(one_day).to be_an_instance_of(DailyWeather)
    expect(one_day.date).to eq(Time.at(forecast[:daily][0][:dt]).strftime("%B %e, %Y"))
    expect(one_day.sunrise).to eq(Time.at(forecast[:daily][0][:sunrise]).strftime("%B %e, %Y at %I:%M %p"))
    expect(one_day.sunset).to eq(Time.at(forecast[:daily][0][:sunset]).strftime("%B %e, %Y at %I:%M %p"))
    expect(one_day.max_temp).to eq(forecast[:daily][0][:temp][:max])
    expect(one_day.min_temp).to eq(forecast[:daily][0][:temp][:min])
    expect(one_day.conditions).to eq(forecast[:daily][0][:weather][0][:description])
    expect(one_day.icon).to eq(forecast[:daily][0][:weather][0][:icon])
  end
end
