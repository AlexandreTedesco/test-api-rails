class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def signin
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = user.generate_jwt
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
