require 'faker'

JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end

# rental_json = []
# 50.times do
#   rental = {
#     "checkout_date": Faker::Date.backward(14),
#     "due_date": Faker::Date.forward(14),
#     "movie_id": rand(Movie.count) + 1,
#     "customer_id": rand(Customer.count) + 1
#   }
#
#   rental_json << rental
# end
#
# File.open("db/seeds/rentals.json","w") do |f|
#   f.write(rental_json.to_json)
# end
#
# JSON.parse(File.read('db/seeds/rentals.json')).each do |rental|
#   Rental.create!(rental)
# end
