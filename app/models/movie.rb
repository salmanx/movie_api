class Movie < ApplicationRecord
  include PgSearch::Model

  belongs_to :category
  belongs_to :user
  has_many :ratings, dependent: :destroy

  pg_search_scope :search_for,
                  against: %i[title text],
                  using: { tsearch: { dictionary: 'english' } },
                  associated_against: { category: :name }

  self.per_page = 9

  def self.fetch_movies(params)
    movies = Movie.all
    if params[:category].present?
      movies = movies.where(category_id: params[:category].to_i)
    end
    if params[:rating].present?
      movies =
        movies.joins(:ratings).merge(
          Rating.group('movies.id').having("AVG(rating) = #{params[:rating]}")
        )
    end
    return movies
  end

  def self.find_by_ratings(rate)
    Movie.joins(:ratings).merge(
      Rating.group('movies.id').having("AVG(rating) = #{rate}")
    )
  end

  def rating
    if self.ratings.size > 0
      # self.ratings.average(:rating)
      (self.ratings.sum(:rating) / self.ratings.size.to_f).floor
    end
  end
end
