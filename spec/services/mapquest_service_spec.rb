require 'rails_helper'

RSpec.describe MapquestService do
  describe 'class methods', :vcr do
    let(:location) { 'denver,co' }

    it '::conn' do
      expect(MapquestService.conn).to be_a(Faraday::Connection)
    end

    it '::coordinates_by_city_state' do
      expect(MapquestService.coordinates_by_city_state(location)).to be_a(Hash)
      expect(MapquestService.coordinates_by_city_state(location)).to have_key(:results)
      expect(MapquestService.coordinates_by_city_state(location)[:results]).to be_an(Array)

      expect(MapquestService.coordinates_by_city_state(location)[:results][0]).to be_a(Hash)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0]).to have_key(:locations)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations]).to be_an(Array)

      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0]).to be_a(Hash)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0]).to have_key(:latLng)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0][:latLng]).to be_a(Hash)

      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)

      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(MapquestService.coordinates_by_city_state(location)[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end
