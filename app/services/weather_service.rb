class WeatherService
  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org/data/2.5/')
  end

  def self.forecast_by_coordinates(location)
    response = conn.get('onecall') do |req|
      req.params['appid'] = ENV['open_weather_api_key']
      req.params['lat'] = location.latitude
      req.params['lon'] = location.longitude
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
