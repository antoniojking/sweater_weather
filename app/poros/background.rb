class Background
  attr_reader :id,
              :location,
              :description,
              :image_url,
              :credit

  def initialize(image, location)
    @id                       = 'null'
    @location                 = location
    @description              = image[:description]
    @image_url                = image[:urls][:raw]
    @credit                   = credit_hash(image[:user])
  end

  def credit_hash(image)
    {
      source: 'unsplash.com',
      photographer: image[:name],
      photographer_profile_url: image[:links][:html]
    }
  end
end
