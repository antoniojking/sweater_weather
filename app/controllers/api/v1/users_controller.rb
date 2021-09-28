class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)

    if new_user.save
      render(json: UserSerializer.new(new_user), status: :created)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
