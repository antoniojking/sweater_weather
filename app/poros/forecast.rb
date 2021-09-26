class Forecast
  attr_reader :id,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(current, hourly, daily)
    @id              = 'null'
    @current_weather = CurrentWeather.new(current)
    @hourly_weather  = hourly.map { |hour| HourlyWeather.new(hour) }
    @daily_weather   = daily.map { |day| DailyWeather.new(day) }
  end
end
