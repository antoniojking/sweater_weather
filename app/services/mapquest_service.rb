class MapquestService
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com/')
  end

  def self.coordinates_by_city_state(location)
    response = conn.get('geocoding/v1/address') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['location'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.directions_by_locations(origin, destination)
    response = conn.get('directions/v2/route') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['from'] = origin
      req.params['to'] = destination
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
