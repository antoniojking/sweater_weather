require 'rails_helper'

RSpec.describe Background do
  it 'exists', :vcr do
    location = 'denver,co'

    conn = Faraday.new(url: 'https://api.unsplash.com/')
    response = conn.get('search/photos') do |req|
      req.params[:client_id] = ENV['unsplash_api_key']
      req.params[:query] = location
      req.params[:per_page] = 1
    end
    json = JSON.parse(response.body, symbolize_names: true)

    image = json[:results][0]

    source       = 'unsplash.com'
    description  = image[:description]
    image_url    = image[:urls][:raw]
    photographer = image[:user][:name]
    profile_url  = image[:user][:links][:html]

    background = Background.new(image, location)

    expect(background).to be_a(Background)
    expect(background.id).to eq('null')
    expect(background.location).to eq(location)
    expect(background.description).to eq(description)
    expect(background.image_url).to eq(image_url)
    expect(background.credit).to eq({
      source: source,
      photographer: photographer,
      photographer_profile_url: profile_url
    })
  end
end
