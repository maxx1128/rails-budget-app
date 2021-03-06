# This file should contain all the record creation needed to seed the database with its default values.

16.times do
  Category.create!(name: Faker::Pokemon.name, 
                   description: Faker::HarryPotter.quote, 
                   budget: Faker::Number.between(200, 500), 
                   expense: Faker::Boolean.boolean)
end



all_categories = Category.all

all_categories.each do |category|

  24.times do |n|

    created_at_date = (n-1).months.ago

    10.times do
      category.expenses.create!( name: Faker::Zelda.character,
                                 description: Faker::Seinfeld.quote,
                                 value: Faker::Number.between(30, 50),
                                 created_at: created_at_date)
    end
  end
end
