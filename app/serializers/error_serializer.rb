class ErrorSerializer
  def self.missing_params
    {
      message: 'Params must be specified',
      status: 'bad request'
    }
  end

  def self.invalid_params
    {
      message: 'Zero results matched your search',
      status: 'bad request'
    }
  end

  def self.unprocessed_entity
    {
      message: 'Invalid json request',
      status: '422: unprocessable entity'
    }
  end
end
