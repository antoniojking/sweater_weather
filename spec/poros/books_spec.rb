require 'rails_helper'

RSpec.describe Books do
  it 'exists', :vcr do
    coordinates = MapquestFacade.coordinates_by_city_state('denver,co')
    forecast = WeatherFacade.

    expect(books).to be_a(Books)
    expect(books.id).to eq('null')
    expect(books.destination).to eq()
    expect(books.forecast).to eq()
    expect(books.total_books_found).to eq()
    expect(books.books).to be_a(Array)
  end
end
