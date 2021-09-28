class Api::V1::BackgroundsController < ApplicationController
  def index
    if params_blank?
      render(json: ErrorSerializer.missing_params, status: :bad_request)
    elsif params_invalid?
      render(json: ErrorSerializer.invalid_params, status: :bad_request)
    else
      background = BackgroundFacade.image_by_location(params[:location])
      render(json: BackgroundSerializer.new(background))
    end
  end

  private

  def params_blank?
    params[:location].blank?
  end

  def params_invalid?
    BackgroundService.image_by_location(params[:location])[:results].empty?
  end
end
