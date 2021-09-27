class Api::V1::BooksSerializer
  include FastJsonapi::ObjectSerializer
  set_type :books
  set_id :id
  attributes :destination, :forecast, :total_books_found, :books
end
