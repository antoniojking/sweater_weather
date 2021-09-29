class MapquestFacade
  def self.coordinates_by_city_state(location)
    json = MapquestService.coordinates_by_city_state(location)

    coordinates = json[:results][0][:locations][0][:latLng]
    Location.new(coordinates)
  end

  def self.travel_time_by_locations(origin, destination)
    json = MapquestService.directions_by_locations(origin, destination)

    time = json[:route][:time]
    Route.new(time)
  end
end
