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

    #results = array
    image = json[:results][0]

    source       = 'https://unsplash.com'
    description  = image[:description]
    image_url    = image[:urls][:raw]
    photographer = image[:user][:name]
    profile_url  = image[:user][:links][:html]

    background = Background.new(image)
    render(json: BackgroundsSerializer.new(background))
  end
end
