# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["Food", "Home", "Rent", "Books", "Health/Fitness", "Student Debt", "Personal"]

categories.each do |category|
  descr = "#{}"
  Category.create!(name: category, description: Faker::Lorem.sentence(3, true), budget: Faker::Number.between(50, 400))
end
