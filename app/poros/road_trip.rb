class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, time, forecast)
    @id = 'null'
    @start_city = origin
    @end_city = destination
    @travel_time = impossible_route?(time)
    @weather_at_eta = weather_hash(forecast, time)
  end

  def travel_time_conversion(time)
    hours = time / 3600
    mins = (time / 60) % 60
    "#{hours} hours and #{mins} minutes"
  end

  def weather_hash(forecast, time)
    if time == 0
      { temperature: '', conditions: '' }
    else
      {
        temperature: forecast.temperature,
        conditions: forecast.conditions
      }
    end
  end

  def impossible_route?(time)
    time == 0 ? 'Impossible route' : travel_time_conversion(time)
  end
end
