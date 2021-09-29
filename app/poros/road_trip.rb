class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination)
    @id = 'null'
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time_conversion(origin, destination)
    @weather_at_eta = weather_hash(origin, destination)
  end

  def travel_time_conversion(origin, destination)
    seconds = MapquestFacade.travel_time_by_locations(origin, destination).travel_time
    hours = seconds / 3600
    mins = (seconds / 60) % 60
    "#{hours} hours and #{mins} minutes"
  end

  def weather_hash(origin, destination)
    seconds = MapquestFacade.travel_time_by_locations(origin, destination).travel_time
    forecast = WeatherFacade.forecast_nearest_hour(destination, seconds)
    {
      temperature: forecast.temperature,
      conditions: forecast.conditions,
      note: 'impossible'
    }
  end
end
