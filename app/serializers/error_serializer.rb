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

  def self.unprocessable_entity
    {
      message: 'Invalid json request',
      status: '422: unprocessable entity'
    }
  end

  def self.email_exists
    {
      message: 'Email already exists',
      status: '422: unprocessable entity'
    }
  end

  def self.passwords_dont_match
    {
      message: 'Password inputs dont match',
      status: '422: unprocessable entity'
    }
  end

  def self.invalid_credentials
    {
      message: 'Email/password are incorrect',
      status: '422: unprocessable entity'
    }
  end

  def self.api_key_invalid
    {
      message: 'The api key provided is incorrect',
      status: '422: unprocessable entity'
    }
  end

  def self.api_key_missing
    {
      message: 'An api key must be provided',
      status: '422: unprocessable entity'
    }
  end
end
