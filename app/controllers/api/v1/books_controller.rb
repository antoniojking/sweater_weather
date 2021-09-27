class Api::V1::BooksController < ApplicationController
  def search
    require "pry"; binding.pry
    location = params[:location]
    quantity = params[:quantity]

    conn = Faraday.new(url: '')
  end
end
