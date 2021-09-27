class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]

    conn = Faraday.new(url: 'https://api.unsplash.com/')
    response = conn.get('search/photos') do |req|
      req.params[:client_id] = ENV['unsplash_api_key']
      req.params[:query] = location
      req.params[:per_page] = 1
    end
    json = JSON.parse(response.body, symbolize_names: true)

    image = json[:results][0]

    background = Background.new(image, location)
    render(json: BackgroundSerializer.new(background))
  end
end
