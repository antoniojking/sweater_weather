require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists', :vcr do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'
    time = MapquestFacade.travel_time_by_locations(origin, destination).travel_time
    travel_time = "#{time / 3600} hours and #{(time / 60) % 60} minutes"
    forecast = WeatherFacade.forecast_nearest_hour(destination, time)
    roadtrip1 = RoadTrip.new(origin, destination, time, forecast)

    expect(roadtrip1).to be_a(RoadTrip)
    expect(roadtrip1.id).to eq('null')
    expect(roadtrip1.start_city).to eq(origin)
    expect(roadtrip1.end_city).to eq(destination)
    expect(roadtrip1.travel_time).to eq(travel_time)
    expect(roadtrip1.weather_at_eta).to eq({
      temperature: forecast.temperature,
      conditions: forecast.conditions,
      note: 'impossible'
      })
  end
end
