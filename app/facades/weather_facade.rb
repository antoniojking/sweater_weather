class WeatherFacade
  def self.forecast_by_city_state(location)
    coordinates = MapquestFacade.coordinates_by_city_state(location)
    json = WeatherService.forecast_by_coordinates(coordinates)
    current = json[:current]
    hourly = json[:hourly][0..7]
    daily = json[:daily][0..4]

    Forecast.new(current, hourly, daily)
  end
end
