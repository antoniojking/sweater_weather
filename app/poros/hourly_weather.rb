class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(attributes)
    @time        = attributes[:dt]
    @temperature = attributes[:temp]
    @conditions  = attributes[:weather][0][:description]
    @icon        = attributes[:weather][0][:icon]
  end
end
