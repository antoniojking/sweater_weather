class WeatherFacade
  def self.forecast_by_city_state(location)
    coordinates = MapquestFacade.coordinates_by_city_state(location)
    json = WeatherService.forecast_by_coordinates(coordinates)
    current = json[:current]
    hourly = json[:hourly][0..7]
    daily = json[:daily][0..4]

    Forecast.new(current, hourly, daily)
  end

  def self.forecast_nearest_hour(destination, time)
    coordinates = MapquestFacade.coordinates_by_city_state(destination)
    json = WeatherService.forecast_by_coordinates(coordinates)
    hours = time / 3600
    hourly = json[:hourly][hours]

    HourlyWeather.new(hourly)
  end
end
