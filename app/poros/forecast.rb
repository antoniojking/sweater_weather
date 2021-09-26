class Forecast
  attr_reader :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(attributes)
    @current_weather = CurrentWeather.new(attributes[:current_weather])
    @hourly_weather  = attributes[:hourly].map { |hour| HourlyWeather.new(hour) }
    @daily_weather   = attributes[:daily].map { |day| DailyWeather.new(day) }
  end
end
