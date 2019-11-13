class AuthenticationController < ApplicationController
  def authenticate_user    
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def sign_up    
    user = User.find_by(email: params[:email])
    render json: { errors: ['Email is already taken'] }, status: 409  and return if user.present?

    if user.nil?
      new_user = User.create!(user_params)
      render json: payload(new_user)
    else
      render json: {errors: 'Please provide your valid information'}, status: 422
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)    
  end

end