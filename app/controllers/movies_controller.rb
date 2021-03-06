class MoviesController < ApplicationController
  before_action :authenticate_request!, only: %i[create update destroy show]
  before_action :set_movie, only: %i[show update destroy]

  # GET /movies
  def index
    @movies = Movie.fetch_movies(params).paginate(page: params[:page])

    render json: {
             current_page: @movies.current_page,
             per_page: @movies.per_page,
             total_entries: @movies.total_entries,
             total_pages: (@movies.total_entries / @movies.per_page.to_f).ceil,
             entries: ActiveModel::SerializableResource.new(@movies).as_json
           }
  end

  # GET /movies/1
  def show
    render json: @movie
  end

  # POST /movies
  def create
    # @movie = Movie.new(movie_params)
    @movie = current_user.movies.build(movie_params)
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

  def search
    if params[:query].present?
      @movies = Movie.search_for(params[:query]).paginate(page: params[:page])
    else
      @movies = Movie.includes(:category).paginate(page: params[:page])
    end
    render json: {
             current_page: @movies.current_page,
             per_page: @movies.per_page,
             total_entries: @movies.total_entries,
             total_pages: (@movies.total_entries / @movies.per_page.to_f).ceil,
             entries: ActiveModel::SerializableResource.new(@movies).as_json
           }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])

    unless @movie.user === current_user
      render json: { errors: ['You are not authorised!'] },
             status: :unauthorized
    else
      @movie
    end
  end

  # Only allow a trusted parameter "white list" through.
  def movie_params
    params.require(:movie).permit(:title, :text, :category_id)
  end
end
