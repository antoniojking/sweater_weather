require 'rails_helper'

RSpec.describe BackgroundService do
  describe 'class methods' do
    let(:location) { 'denver,co' }
    let(:image) { BackgroundService.image_by_location(location) }

    it '::conn' do
      expect(BackgroundService.conn).to be_a(Faraday::Connection)
    end

    it '::image_by_connection', :vcr do
      expect(image).to be_a(Hash)

      expect(image).to have_key(:results)
      expect(image[:results]).to be_an(Array)

      result = image[:results][0]
      expect(result).to have_key(:description)
      expect(result[:description]).to be_a(String)

      expect(result).to have_key(:urls)
      expect(result[:urls]).to be_a(Hash)

      expect(result[:urls]).to have_key(:raw)
      expect(result[:urls][:raw]).to be_a(String)

      expect(result).to have_key(:user)
      expect(result[:user]).to be_a(Hash)

      expect(result[:user]).to have_key(:name)
      expect(result[:user][:name]).to be_a(String)

      expect(result[:user]).to have_key(:links)
      expect(result[:user][:links]).to be_a(Hash)

      expect(result[:user][:links]).to have_key(:html)
      expect(result[:user][:links][:html]).to be_a(String)
    end
  end
end
