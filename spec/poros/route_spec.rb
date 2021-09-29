require 'rails_helper'

RSpec.describe Route do
  it 'exists', :vcr do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'
    json = MapquestService.directions_by_locations(origin, destination)
    roadtrip1 = MapquestFacade.travel_time_by_locations(origin, destination)

    expect(roadtrip1).to be_a(Route)
    expect(roadtrip1.time).to eq(json[:route][:time])
  end
end
