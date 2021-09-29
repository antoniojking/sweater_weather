require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods', :vcr do
    it '::details_by_locations' do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'
      roadtrip = RoadTripFacade.details_by_locations(origin, destination)

      expect(roadtrip).to be_a(RoadTrip)
    end
  end
end
