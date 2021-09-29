class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)

    if new_user.save
      new_user.api_keys.create!(token: SecureRandom.hex)
      render(json: UserSerializer.new(new_user), status: :created)
    elsif email_exists?
      render(json: ErrorSerializer.email_exists, status: :unprocessable_entity)
    elsif passwords_dont_match?
      render(json: ErrorSerializer.passwords_dont_match, status: :unprocessable_entity)
    else
      render(json: ErrorSerializer.unprocessable_entity, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def email_exists?
    User.find_by(email: user_params[:email]) != nil
  end

  def passwords_dont_match?
    user_params[:password] != user_params[:password_confirmation]
  end
end
