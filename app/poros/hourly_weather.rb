class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(attributes)
    @time        = Time.at(attributes[:dt]).strftime("%I:%M %p")
    @temperature = attributes[:temp]
    @conditions  = attributes[:weather][0][:description]
    @icon        = attributes[:weather][0][:icon]
  end
end
