require 'rails_helper'

RSpec.describe MapquestFacade do
  describe 'class methods', :vcr do
    let(:location) { 'denver,co' }

    it '::coordinates_by_city_state' do
      denver = MapquestFacade.coordinates_by_city_state(location)

      expect(denver).to be_a(Location)
    end
  end
end
