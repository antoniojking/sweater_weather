class Books
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books
              
  def initialize(location, forecast, books)
    @id                = 'null'
    @destination       = location
    @forecast          = { summary: forecast.conditions, temperature: "#{forecast.temperature.round(0)} F"}
    @total_books_found = books[:numFound]
    @books             = books_hash(books)
  end

  def books_hash(books)
    books[:docs][0..4].map do |book|
      {
        "isbn": book[:isbn],
        "title": book[:title],
        "publisher": book[:publisher]
      }
    end
  end
end
