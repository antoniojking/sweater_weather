class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])

    if params_blank? || params[:user].blank?
      render(json: ErrorSerializer.missing_params, status: 422)
    elsif @user.nil? || incorrect_password?
      render(json: ErrorSerializer.invalid_credentials, status: 422)
    elsif @user.authenticate(user_params[:password])
      render(json: UserSerializer.new(@user), status: 200)
    end
  end

  private

  def user_params
    if params[:user].blank?
      render(json: ErrorSerializer.unprocessable_entity, status: 422)
    else
      params.require(:user).permit(:email, :password)
    end
  end

  def incorrect_password?
    @user.authenticate(user_params[:password]) == false
  end

  def params_blank?
    user_params[:email].blank? || user_params[:password].blank?
  end
end
