class Api::V1::ForecastController < ApplicationController
  def index
    conn = Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/')

    response = conn.get('address') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['location'] = params[:location]
    end

    json = JSON.parse(response.body, symbolize_names: true)

    coordinates = json[:results][0][:locations][0][:latLng]

    lat = coordinates[:lat]
    lon = coordinates[:lng]

    conn = Faraday.new(url: 'https://api.openweathermap.org/data/2.5/')

    response = conn.get('onecall') do |req|
      req.params['appid'] = ENV['open_weather_api_key']
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'minutely'
    end

    json = JSON.parse(response.body, symbolize_names: true)

    current = json[:current]
    daily = json[:daily][0..4]
    hourly = json[:hourly][0..7]

    @forecast = json
    render(json: ForecastSerializer.new(@forecast))

    # forecast = ForecastFacade.create_weather(params[:city], params[:state])
    # render(json: ForecastSerializer.new(forecast))
  end

  # def index
  #   if params_included? || params_are_empty?
  #     render(json: ErrorSerializer.weather_params_not_included, status: :bad_request)
  #   else
  #     weather = WeatherFacade.create_weather(params[:lat], params[:lon])
  #     render(json: WeatherSerializer.new(weather))
  #   end
  # end
  #
  # private
  #
  # def params_included?
  #   !params[:lat].present? || !params[:lon].present?
  # end
  #
  # def params_are_empty?
  #   params[:lat] == '' || params[:lon] == ''
  # end
end