class Background
  attr_reader :id,
              :source,
              :location,
              :description,
              :image_url,
              :photographer,
              :photographer_profile_url

  def initialize(image, location)
    @id                       = 'null'
    @source                   = 'https://unsplash.com'
    @location                 = location
    @description              = image[:description]
    @image_url                = image[:urls][:raw]
    @photographer             = image[:user][:name]
    @photographer_profile_url = image[:user][:links][:html]
  end
end
