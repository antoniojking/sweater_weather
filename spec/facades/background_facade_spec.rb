require 'rails_helper'

RSpec.describe BackgroundFacade do
  describe 'class methods' do
    it '::image_by_location', :vcr do
      location = 'denver,co'
      image = BackgroundFacade.image_by_location(location)

      expect(image).to be_a(Background)
    end
  end
end
