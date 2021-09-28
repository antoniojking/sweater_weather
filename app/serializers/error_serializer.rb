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
end
