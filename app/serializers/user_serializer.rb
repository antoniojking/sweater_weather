class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :users
  set_id :id
  attributes :email

  attribute :api_key do |object|
    object.api_keys.first.token
  end
end
