class Route
  attr_reader :time

  def initialize(time)
    @time = time
  end

  # def hrs_and_mins(time)
  #   hours = time / 60
  #   mins = time % 60
  #   "#{hours} hours and #{mins} minutes"
  # end
end
