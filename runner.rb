require 'unirest'
require 'paint'

system "clear"

puts "Ready to check out some Fancy Sweatpants?"
puts "What do you want to do?"
puts "       [1] Show all products"
puts "       [2] Show one product"
puts "       [3] Create a new product"
puts "       [4] Update a product"
puts "       [5] Delete a product"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/products")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "2"

  print "Enter the product ID: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body
  puts JSON.pretty_generate(product)

elsif input_option == "3" 
  
  client_params = {}
  
  print "Name: "
  client_params[:name] = gets.chomp

  print "In Stock?: "
  client_params[:in_stock?] = gets.chomp 
  
  print "Price: "
  client_params[:price] = gets.chomp 
  
  print "Image_url: "
  client_params[:image_url] = gets.chomp
  
  print "Description: "
  client_params[:description] = gets.chomp
  
  p client_params
  
  response = Unirest.post(
                          "http://localhost:3000/products",
                           parameters: client_params              
                          )

  if response.code == 200 
    data = response.body
    puts JSON.pretty_generate(data) 
  else 
    errors = response.body["errors"]
    errors.each do |error|
      puts error
    end 
  end 

elsif input_option == "4" 

  print "Enter the product ID: "
  input_id = gets.chomp 

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body 

  client_params = {}
  
  print "Name (#{product["name"]}): "
  client_params[:name] = gets.chomp

  print "In Stock? (#{product["in_stock?"]}): "
  client_params[:in_stock?] = gets.chomp 
  
  print "Price (#{product["price"]}): "
  client_params[:price] = gets.chomp 
  
  print "Image_url (#{product["image_url"]}): "
  client_params[:image_url] = gets.chomp
  
  print "Description (#{product["description"]}): "
  client_params[:description] = gets.chomp
  
  client_params.delete_if{ |key, value| value.empty?}

  response =  Unirest.patch(
              "http://localhost:3000/products/#{input_id}",
              parameters: client_params              
                          )

   if response.code == 200 
    data = response.body
    puts JSON.pretty_generate(data) 
  else 
    errors = response.body["errors"]
    errors.each do |error|
      puts error
    end 
  end

elsif input_option == "5" 

  print "Enter product ID: "
  input_id = gets.chomp 

  response = Unirest.delete("http://localhost:3000/products/#{input_id}")
  data = response.body 
  puts data["message"]

end 
















    


