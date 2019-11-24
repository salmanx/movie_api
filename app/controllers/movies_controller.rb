class MoviesController < ApplicationController
  before_action :authenticate_request!, only: [:create, :update, :destroy]
  before_action :set_movie, only: [:show, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.includes(:category)

    if params[:category].present?
      category = Category.find_by(id: params[:category])
      @movies = category.movies
    else
      @movies = Movie.includes(:category)
    end
    render json: @movies
  end

  # GET /movies/1
  def show
    render json: @movie
  end

  # POST /movies
  def create
    # @movie = Movie.new(movie_params)
    @movie = current_user.movies.build(movie_params)
    @movie.category = Category.find_by(params[:category_id])

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def movie_params
      params.require(:movie).permit(:title, :text, :category_id)
    end
end
