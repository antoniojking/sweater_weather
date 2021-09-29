class MapquestFacade
  def self.coordinates_by_city_state(location)
    json = MapquestService.coordinates_by_city_state(location)

    coordinates = json[:results][0][:locations][0][:latLng]
    Location.new(coordinates)
  end

  def self.travel_time_by_locations(origin, destination)
    json = MapquestService.directions_by_locations(origin, destination)

    if json[:info][:messages].first == "We are unable to route with the given locations."
      time = 0
    else
      time = json[:route][:time]
    end
    Route.new(time)
  end
end
