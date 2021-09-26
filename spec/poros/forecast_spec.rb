require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods', :vcr do
    it 'exits' do
      denver = Forecast.new(attributes)

      expect(denver).to be_an_instance_of(Forecast)
      expect(denver.current_weather).to eq()
      expect(denver.daily_weather).to eq()
      expect(denver.hourly_weather).to eq()
    end
  end
end
