require 'unirest'
require 'paint'

require_relative 'controllers/products_controller'
require_relative 'views/products_views'
require_relative 'models/product'

class Frontend 
  include ProductsController 
  include ProductsViews
  

  def run
    while true 
      system "clear"

      puts "Ready to check out some Fancy Sweatpants?"
      puts "What do you want to do?"
      puts "       [1] Show all products"
      puts "          [1.1] Search all products by name"
      puts "          [1.2] Sort by price"
      puts "          [1.3] Sort by name"
      puts "          [1.4] Sort by description"
      puts "       [2] Show one product"
      puts "       [3] Create a new product"
      puts "       [4] Update a product"
      puts "       [5] Delete a product"
      puts "       [6] Show all orders"
      puts
      puts "       [signup] Songup (create user)"
      puts "       [login] Login (create a JSON web token)"
      puts "       [logout] Logout (erase the JSON web token)"

      puts "       [q] Quit"



      input_option = gets.chomp

      if input_option == "1"
        products_index_action 

      elsif input_option == "1.1"
        products_search_action

      elsif input_option == "1.2"
        products_sort_action("price")

      elsif input_option == "1.3"
        products_sort_action("name")
        
      elsif input_option == "1.4"
        products_sort_action("description")
    
      elsif input_option == "2"
        products_show_action

      elsif input_option == "3" 
        products_create_action 

      elsif input_option == "4" 
        products_update_action

      elsif input_option == "5" 
        products_destroy_action 

      elsif input_option == "6"
        order_hashs = get_request("/orders")
        reponse = Unirest.get("http://localhost:3000/orders")
        if response.code == 200
          puts JSON.pretty_generate(response.body)
        elsif response.code == 401 
          puts "You need to sign in to make a order"
        end 
        puts JSON.pretty_generate(order_hashs)
          
      elsif input_option == "signup"
        puts "Signup for a new account"
        puts 
        client_params = {}

        print "Name: "
        client_params[:name] = gets.chomp
        print "Email: "
        client_params[:email] = gets.chomp 
        print "Password: "
        client_params[:password] = gets.chomp 
        print "Password Confirmation: " 
        client_params[:password_confirmation] = gets.chomp 

        json_data = post_request("/users", client_params)
        puts JSON.pretty_generate(json_data)

      elsif input_option == "login"
        puts "Login"
        puts
        puts "Email: "
        input_email = gets.chomp 

        print "Password: "
        input_password = gets.chomp
        response = Unirest.post(
                                "http://localhost:3000/user_token",
                                parameters: {
                                              auth: {
                                                      email: input_email,
                                                      password: input_password
                                                     }
                                            }
                                )
        puts JSON.pretty_generate(response.body)
        jwt = response.body["jwt"]
        Unirest.default_header("Authorization", "Bearer #{jwt}")

      elsif input_option == "logout"
        jwt = ""
        Unirest.clear_default_headers 
        
      elsif input_option == "q"
          puts "Thank you for visiting this site"
          exit 
      end 
      puts "Hit any key to continue, enter q to exit"
      gets.chomp
    end     
  end 

private 
  def get_request(url, client_params={}) 
    Unirest.get("http://localhost:3000#{url}", parameters: client_params).body
  end 

  def post_request(url, client_params={})
    Unirest.post("http://localhost:3000#{url}", parameters: client_params).body
  end 

  def patch_request(url, client_params={})
    Unirest.patch("http://localhost:3000#{url}", parameters: client_params).body
  end 

  def delete_request(url, client_params={})
    Unirest.delete("http://localhost:3000#{url}", parameters: client_params).body
  end 
end

# Frontend.new.run 