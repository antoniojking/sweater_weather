class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :users
  set_id :id
  attributes :email
end
