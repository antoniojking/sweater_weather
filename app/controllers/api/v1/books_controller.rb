class Api::V1::BooksController < ApplicationController
  def search
    location = params[:location]
    quantity = params[:quantity]

    conn = Faraday.new(url: 'http://openlibrary.org/')

    response = conn.get('search.json') do |req|
      req.params[:q] = params[:location]
    end

    json = JSON.parse(response.body, symbolize_names: true)

    total_books_found = json[:numFound]
    books = json[:docs][0..4]

    attributes = books.map do |book|
      book[:title]
      book[:isbn]
      book[:publisher]
    end
    require "pry"; binding.pry
  end
end
