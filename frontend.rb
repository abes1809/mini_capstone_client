require 'unirest'
require 'paint'

require_relative 'controllers/products_controller'
require_relative 'views/products_views'
require_relative 'models/product'

class Frontend 
  include ProductsController 
  include ProductsViews
  

  def run
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
    end 
  end 

private 
  def get_request(url, client_params={}) 
    Unirest.get("http://localhost:3000#{url}, parameters: client_params").body
  end 

  def post_request(url, client_params={})
    Unirest.post("http://localhost:3000#{url}, parameters: client_params").body
  end 

  def patch_request(url, client_params={})
    Unirest.patch("http://localhost:3000#{url}, parameters: client_params").body
  end 

  def delete_request(url, client_params={})
    Unirest.delete("http://localhost:3000#{url}, parameters: client_params").body
  end 
end

# Frontend.new.run 