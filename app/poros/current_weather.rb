class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(attributes)
    @datetime    = Time.at(attributes[:dt]).strftime('%B %e, %Y at %I:%M %p')
    @sunrise     = Time.at(attributes[:sunrise]).strftime('%B %e, %Y at %I:%M %p')
    @sunset      = Time.at(attributes[:sunset]).strftime('%B %e, %Y at %I:%M %p')
    @temperature = attributes[:temp]
    @feels_like  = attributes[:feels_like]
    @humidity    = attributes[:humidity]
    @uvi         = attributes[:uvi]
    @visibility  = attributes[:visibility]
    @conditions  = attributes[:weather][0][:description]
    @icon        = attributes[:weather][0][:icon]
  end
end
