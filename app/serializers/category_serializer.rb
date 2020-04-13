class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :total_movies

  def total_movies
  	object.movies.count
  end
end
