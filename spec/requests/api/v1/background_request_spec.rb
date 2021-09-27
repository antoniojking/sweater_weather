require 'rails_helper'

RSpec.describe 'Background Api' do
  describe 'happy path' do
    it 'returns background image for queried city', :vcr do
      get '/api/v1/backgrounds', params: { location: 'denver,co' }

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      photo = json[:data]
      expect(photo).to be_a(Hash)
      expect(photo.keys.size).to eq(3)
      expect(photo).to have_key(:id)
      expect(photo[:id]).to be_a(String)
      expect(photo).to have_key(:type)
      expect(photo[:type]).to be_a(String)
      expect(photo).to have_key(:attributes)

      attributes = photo[:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes.keys.size).to eq(1)
      expect(attributes).to have_key(:image)

      image = attributes[:image]
      expect(image).to be_a(Hash)
      expect(image.keys.size).to eq(3)
      expect(image).to have_key(:location)
      expect(image[:location]).to be_a(String)
      expect(image).to have_key(:image_url)
      expect(image[:image_url]).to be_a(String)
      expect(image).to have_key(:credit)

      credit = image[:credit]
      expect(credit).to be_a(Hash)
      expect(credit.keys.size).to be_a(3)
      expect(credit).to have_key(:source)
      expect(credit[:source]).to be_a(String)
      expect(credit).to have_key(:photographer)
      expect(credit[:photographer]).to be_a(String)
      expect(credit).to have_key(:photographer_profile_url)
      expect(credit[:photographer_profile_url]).to be_a(String)
    end
  end
end
