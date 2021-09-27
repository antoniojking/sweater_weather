class Api::V1::ForecastController < ApplicationController
  def index
    if params_blank?
      render(json: ErrorSerializer.weather_params_not_included, status: :bad_request)
    else
      forecast = WeatherFacade.forecast_by_city_state(params[:location])
      render(json: ForecastSerializer.new(forecast))
    end
  end

  private

  def params_blank?
    params[:location].blank?
  end
end
