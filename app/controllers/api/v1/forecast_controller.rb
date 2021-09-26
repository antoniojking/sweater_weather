class Api::V1::ForecastController < ApplicationController
  def index
    location = MapquestFacade.coordinates_by_city_state(params[:location])

    conn = Faraday.new(url: 'https://api.openweathermap.org/data/2.5/')

    response = conn.get('onecall') do |req|
      req.params['appid'] = ENV['open_weather_api_key']
      req.params['lat'] = location.latitude
      req.params['lon'] = location.longitude
      req.params['exclude'] = 'minutely'
    end

    json = JSON.parse(response.body, symbolize_names: true)

    current = json[:current]
    daily = json[:daily][0..4]
    hourly = json[:hourly][0..7]

    @forecast = Forecast.new(json)
    render(json: ForecastSerializer.new(@forecast))

    #create test for forecast poro
    #create poro
    #create test for forecast facade
    #create facade
    #call on facade in controller to create forecast object with attributes
    #use forecast object in serializer
    #render serializer in controller
    #refactor mapquest and weather apis to facade/services/poros
    #review sad and edge path testing

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
