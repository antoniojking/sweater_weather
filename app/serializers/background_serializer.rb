class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  set_type :background
  set_id :id
  attributes :location, :description, :image_url, :credit
end
