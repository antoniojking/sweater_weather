class BackgroundFacade
  def self.image_by_location(location)
    json = BackgroundService.image_by_location(location)
    image = json[:results][0]

    Background.new(image, location)
  end
end
