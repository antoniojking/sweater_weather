class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])

    if params_blank? || params[:user].blank?
      render(json: ErrorSerializer.missing_params, status: :unprocessable_entity)
    elsif @user.nil? || incorrect_password?
      render(json: ErrorSerializer.invalid_credentials, status: :unprocessable_entity)
    elsif @user.authenticate(user_params[:password])
      render(json: UserSerializer.new(@user), status: :ok)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def incorrect_password?
    @user.authenticate(user_params[:password]) == false
  end

  def params_blank?
    user_params[:email].blank? || user_params[:password].blank?
  end
end
