class MapquestService
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/')
  end

  def self.coordinates_by_city_state(location)
    response = conn.get('address') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['location'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
