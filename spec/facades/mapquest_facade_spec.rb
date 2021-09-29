require 'rails_helper'

RSpec.describe MapquestFacade do
  describe 'class methods', :vcr do
    let(:location) { 'denver,co' }

    it '::coordinates_by_city_state' do
      denver = MapquestFacade.coordinates_by_city_state(location)

      expect(denver).to be_a(Location)
    end

    it '::travel_time_by_locations' do
      destination = 'Pueblo,CO'
      roadtrip1 = MapquestFacade.travel_time_by_locations(location, destination)

      expect(roadtrip1).to be_a(Route)
    end
  end
end
