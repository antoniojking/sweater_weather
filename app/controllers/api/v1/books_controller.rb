class Api::V1::BooksController < ApplicationController
  def search
    location = params[:location]
    quantity = params[:quantity]

    forecast = WeatherFacade.forecast_by_city_state(location).current_weather

    conn = Faraday.new(url: 'http://openlibrary.org/')

    response = conn.get('search.json') do |req|
      req.params[:q] = params[:location]
    end

    json = JSON.parse(response.body, symbolize_names: true)

    books = Books.new(location, forecast, json)
    render(json: BooksSerializer.new(books))
  end
end
