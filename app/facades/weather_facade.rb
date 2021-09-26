class WeatherFacade
  def self.forecast_by_coordinates(location)
    json = WeatherService.forecast_by_coordinates(location)
    current = json[:current]
    hourly = json[:hourly][0..7]
    daily = json[:daily][0..4]
    
    Forecast.new(current, hourly, daily)
  end
end
