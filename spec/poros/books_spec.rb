require 'rails_helper'

RSpec.describe Books do
  it 'exists', :vcr do
    location = 'denver,co'
    forecast = WeatherFacade.forecast_by_city_state(location)
    current = forecast.current_weather

    conn = Faraday.new(url: 'http://openlibrary.org/')
    response = conn.get('search.json') do |req|
      req.params[:q] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
    total_books_found = json[:numFound]
    results = json[:docs][0..4]

    books = Books.new(location, current, json)

    expect(books).to be_a(Books)
    expect(books.id).to eq('null')
    expect(books.destination).to eq(location)
    expect(books.forecast).to eq({
      summary: current.conditions,
      temperature: "#{current.temperature.round(0)} F"
    })

    expect(books.total_books_found).to eq(total_books_found)

    expect(books.books.size).to eq(5)
    expect(books.books.first).to eq({
      "isbn": results[0][:isbn],
      "title": results[0][:title],
      "publisher": results[0][:publisher]
    })
  end
end
