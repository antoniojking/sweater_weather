class RoadTripFacade
  def self.details_by_locations(origin, destination)
    time = MapquestFacade.travel_time_by_locations(origin, destination).travel_time
    forecast = WeatherFacade.forecast_nearest_hour(destination, time)
    
    RoadTrip.new(origin, destination, time, forecast)
  end
end
