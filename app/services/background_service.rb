class BackgroundService
  def self.conn
    Faraday.new(url: 'https://api.unsplash.com/')
  end

  def self.image_by_location(location)
    response = conn.get('search/photos') do |req|
      req.params[:client_id] = ENV['unsplash_api_key']
      req.params[:query] = location
      req.params[:per_page] = 1
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
