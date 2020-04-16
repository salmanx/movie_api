class UsersController < ApplicationController
  before_action :authenticate_request!, only: %i[update show destroy movies]

  def movies
    @movies = current_user.movies
    render json: @movies
  end

  def update
    if current_user.update!(user_params)
      render json: { user: current_user }
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: { user: user }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
