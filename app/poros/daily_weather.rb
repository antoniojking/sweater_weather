class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(attributes)
    @date       = attributes[:dt]
    @sunrise    = attributes[:sunrise]
    @sunset     = attributes[:sunset]
    @max_temp   = attributes[:temp][:max]
    @min_temp   = attributes[:temp][:min]
    @conditions = attributes[:weather][0][:description]
    @icon       = attributes[:weather][0][:icon]
  end
end
