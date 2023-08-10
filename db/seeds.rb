puts "Cleaning database..."
Shop.destroy_all
User.destroy_all
Review.destroy_all

puts "Creating shops"
Shop.create(
 name: "Europas Grösstes Secondhand-Kaufhaus",
 street: "Frankfurter Tor 3",
 zipcode: "10243",
 city: "Berlin",
 neighbourhood: "Friedrichshain",
 popup: false
)
puts "Finished..."
