# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Category.delete_all
Movie.delete_all
User.delete_all

categories = ["Action", "Thrilling", "Romance", "History", "War"]
user = User.create(email: "salman@mail.com", password: "secret")
categories.each do |category|
    cat = Category.create!(name: category)
    (1..10).each do
        cat.movies.create!(
            title: Faker::Book.title,
            text: Faker::Movie.quote,
            user: user
        )
    end
end
