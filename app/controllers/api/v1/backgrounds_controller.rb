class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundFacade.image_by_location(params[:location])
    render(json: BackgroundSerializer.new(background))
  end
end
