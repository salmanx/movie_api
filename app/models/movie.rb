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

  def self.find_by_ratings(rate)
    movies = []
    Movie.all.each { |m| movies << m if m&.rating <= rate }
    return movies
  end

  def rating
    if self.ratings.size > 0
      (self.ratings.sum(:rating) / self.ratings.size.to_f).ceil
    end
  end

  # Movie.joins(:ratings).group('ratings.size').having('average(rating.size) > ?', 3)
end
