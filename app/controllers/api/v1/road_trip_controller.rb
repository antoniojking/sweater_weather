class Api::V1::RoadTripController < ApplicationController
  def create
    @api = ApiKey.find_by(token: params[:api_key])
    origin = params[:origin]
    destination = params[:destination]

    if params_missing?
      render(json: ErrorSerializer.missing_params, status: :unprocessable_entity)
    elsif api_valid?
      roadtrip = RoadTripFacade.details_by_locations(origin, destination)
      render(json: RoadTripSerializer.new(roadtrip), status: :ok)
    elsif params[:api_key].blank?
      render(json: ErrorSerializer.api_key_missing, status: :unauthorized)
    else
      render(json: ErrorSerializer.api_key_invalid, status: :unauthorized)
    end
  end

  private

  def api_valid?
    @api != nil
  end

  def params_missing?
    params[:origin].blank? || params[:destination].blank?
  end
end
