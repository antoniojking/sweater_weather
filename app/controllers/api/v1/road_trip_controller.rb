class Api::V1::RoadTripController < ApplicationController
  def create
    @api = ApiKey.find_by(token: params[:api_key])
    origin = params[:origin]
    destination = params[:destination]
    roadtrip = RoadTripFacade.details_by_locations(origin, destination)

    if api_valid?
      render(json: RoadTripSerializer.new(roadtrip), status: :ok)
    else
      render(json: ErrorSerializer.api_key_invalid, status: :unprocessable_entity)
    end
  end

  private

  def api_valid?
    @api != nil
  end
end
