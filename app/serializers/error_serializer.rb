class ErrorSerializer
  def self.weather_params_not_included
    {
      message: 'Location params must be specified',
      status: 'bad request'
    }
  end
end
