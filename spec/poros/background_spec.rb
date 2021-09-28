require 'rails_helper'

RSpec.describe Background do
  it 'exists', :vcr do
    location = 'denver,co'
    image = BackgroundService.image_by_location(location)[:results][0]
    background = Background.new(image, location)

    expect(background).to be_a(Background)
    expect(background.id).to eq('null')
    expect(background.location).to eq(location)
    expect(background.description).to eq(image[:description])
    expect(background.image_url).to eq(image[:urls][:raw])
    expect(background.credit).to eq({
      source: 'unsplash.com',
      photographer: image[:user][:name],
      photographer_profile_url: image[:user][:links][:html]
    })
  end
end
