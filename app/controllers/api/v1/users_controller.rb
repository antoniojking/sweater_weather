class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)

    if new_user.save
      new_user.api_keys.create!(token: SecureRandom.hex)
      render(json: UserSerializer.new(new_user), status: 201)
    else
      render(json: ErrorSerializer.unprocessed_entity, status: 422)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
