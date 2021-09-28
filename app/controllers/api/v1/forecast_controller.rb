class Api::V1::ForecastController < ApplicationController
  def index
    if params_blank?
      render(json: ErrorSerializer.missing_params, status: :bad_request)
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
