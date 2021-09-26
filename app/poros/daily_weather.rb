class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(attributes)
    @date       = Time.at(attributes[:dt]).strftime("%B %e, %Y")
    @sunrise    = Time.at(attributes[:sunrise]).strftime("%B %e, %Y at %I:%M %p")
    @sunset     = Time.at(attributes[:sunset]).strftime("%B %e, %Y at %I:%M %p")
    @max_temp   = attributes[:temp][:max]
    @min_temp   = attributes[:temp][:min]
    @conditions = attributes[:weather][0][:description]
    @icon       = attributes[:weather][0][:icon]
  end
end
