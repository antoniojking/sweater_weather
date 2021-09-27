class Api::V1::BooksController < ApplicationController
  def search
    location = params[:location]
    quantity = params[:quantity].to_i

    forecast = WeatherFacade.forecast_by_city_state(location).current_weather

    conn = Faraday.new(url: 'http://openlibrary.org/')

    response = conn.get('search.json') do |req|
      req.params[:q] = params[:location]
    end

    json = JSON.parse(response.body, symbolize_names: true)

    total = json[:numFound]

    results = json[:docs].take(quantity)

    books = Books.new(location, forecast, results, total)
    render(json: BooksSerializer.new(books))
  end
end
