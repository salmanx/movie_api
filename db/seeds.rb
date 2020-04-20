# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Category.delete_all
Movie.delete_all
User.delete_all

categories = %w[Action Thrilling Romance History War]
user = User.create(email: 'salman@gmail.com', password: 'secret')
categories.each do |category|
  cat = Category.create!(name: category)
  (1..10).each do
    cat.movies.create!(
      title: Faker::Book.title, text: Faker::Movie.quote, user: user
    )
  end
end

(1..30).each do |r|
  rating = Rating.new(movie_id: rand(1..10), user_id: 1, rating: rand(1..5))
  rating.save
end
