class RatingController < ApplicationController
  before_action :authenticate_request!, only: [:create]

  def create
    # raise params.inspect
    rating = Rating.new(rating_params)
    if current_user.ratings.save!
      render json: rating
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:rating, :movies_id)
    end
end
