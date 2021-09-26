class Api::V1::ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_type :forecast
  set_id :id
  attributes :current_weather, :daily_weather, :hourly_weather
end
