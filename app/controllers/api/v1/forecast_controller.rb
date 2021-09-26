class Api::V1::ForecastController < ApplicationController
  def index
    location = MapquestFacade.coordinates_by_city_state(params[:location])
    forecast = WeatherFacade.forecast_by_coordinates(location)
    render(json: ForecastSerializer.new(forecast))

    #use forecast object in serializer
    #render serializer in controller
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
