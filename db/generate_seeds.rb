require 'faker'
require 'pry'

binding.pry
rental_json = []
5.times do
  rental = {
    "checkout_date": Faker::Date.backward(14),
    "due_date": Faker::Date.forward(14),
    "movie_id": rand(Movie.count) + 1,
    "customer_id": rand(Customer.count) + 1
  }

  rental_json << rental

end

File.open("db/seeds/rentals.json","w") do |f|
  f.write(rental_json.to_json)
end
