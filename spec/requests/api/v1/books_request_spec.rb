require 'rails_helper'

RSpec.describe 'Book Search Api' do
  describe 'happy path', :vcr do
    it 'returns books realted to location' do
      get 'api/v1/book-search', params: { location: 'denver,co', quantity: 5 }

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      data = json[:data]
      expect(data).to be_a(Hash)
      expect(data.keys.size).to eq(3)
      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data).to have_key(:attributes)

      attributes = books[:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes.keys.size).to eq(4)
      expect(attributes).to have_key(:destination)
      expect(attributes).to have_key(:forecast)
      expect(attributes).to have_key(:total_books_found)
      expect(attributes).to have_key(:books)

      destination = attributes[:destination]
      expect(destination).to be_a(String)

      forecast = attributes[:forecast]
      expect(forecast).to be_a(Hash)
      expect(forecast.keys.size).to eq(2)
      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a(String)
      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a(String)

      total_books_found = attributes[:total_books_found]
      expect(total_books_found).to be_an(Integer)


      books = attributes[:books]
      expect(books).to be_an(Array)

      books.each do |book|
        expect(book).to be_a(Hash)
        expect(book.keys.size).to eq(3)

        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an(Array)

        book[:isbn].each do |isbn|
          expect(isbn).to be_a(String)
        end

        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)

        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an(Array)

        book[:publisher].each do |publisher|
          expect(publisher).to be_a(String)
        end
      end
    end
  end
end
