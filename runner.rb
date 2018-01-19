require 'unirest'
require 'paint'

system "clear"

# puts "Ready to check out some Fancy Sweatpants?"
# puts "What do you want to do?"
# puts "       [1] Show all products"

puts "Create a new product!"
client_params = {}

print "Name: "
client_params[:name] = gets.chomp

print "Price: "
client_params[:price] = gets.chomp 

print "Image_url: "
client_params[:image_url] = gets.chomp

print "Description: "
client_params[:description] = gets.chomp

p client_params

response = Unirest.post("http://localhost:3000/products",
                      parameters: client_params
                      )

data = response.body 

# puts Paint['This is your new produt', :red]
puts JSON.pretty_generate(data) 


