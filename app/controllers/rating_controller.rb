class RatingController < ApplicationController
  before_action :authenticate_request!, only: %i[create]

  def create
    rating = Rating.new(rating_params)
    rating.user = current_user
    if rating.save
      render json: rating
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :movie_id)
  end
end
