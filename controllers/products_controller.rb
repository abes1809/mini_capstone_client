module ProductsController 

  def products_index_action
   product_hashs = get_request("/products")
   products = Product.convert_hashes(product_hashs)

   products_index_view(products)
  end 

  def products_show_action 
    input_id = products_id_form

    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    products_show_view(product)

    puts "press enter to continue or type 'add' to add to cart"
    user_choice = gets.chomp 
    if user_choice == "add"
      print "Enter a quantity to order: "
      input_quantity = gets.chomp 
      client_params = {
                        quantity: input_quantity,
                        product_id: input_id 
                        }
      # json_data = post_request("/orders", client_params)

      response = Unirest.post("http://localhost:3000/carted_products", parameters: client_params)
      
      if response.code == 200
        puts JSON.pretty_generate(response.body)
      elsif response.code == 401 
        puts "Nope, try logging in first"
      end
    end 
  end

  def products_create_action
    client_params = products_new_form
    # response = Unirest.post(
    #                           "http://localhost:3000/products",
    #                            parameters: client_params              
    #                           )

    # json_data = post_request("/product", client_params)
    response = Unirest.post("http://localhost:3000/products", parameters: client_params)

      if response.code == 200
        product = Products.new(response.body)
        products_show_view(product)
      elsif response.code == 422
        errors = repsonse.body["errors"]
        products_errors_view(errors)
      elsif response.code == 401
        puts JSON.pretty_generate(response.body)
      end 
  end 

  def products_update_action
      input_id = products_id_form

      product_hash = get_request("/products/#{input_id}") 
      product = Product.new(product_hash)

      client_params = products_update_form(product)

      # response =  Unirest.patch(
      #             "http://localhost:3000/products/#{input_id}",
      #             parameters: client_params              
      #                         )

      # json_data = patch_request("/products/#{input_id}")

      response = Unirest.patch("http://localhost:3000/products/#{input_id}", parameters: client_params)

      if response.code == 200
        product = Product.new(response.body)
        products_show_view(product) 
      elsif response.code == 422
        errors = response.body["errors"]
        products_errors_view(errors)
      elsif response.code == 401 
        puts JSON.pretty_generate(response.body)
      end
  end

  def products_destroy_action

    print "Enter product ID: "
    input_id = gets.chomp 

    # response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    json_data = delete_request("/products/#{input_id}")

    puts json_data["message"]
  end

  def prodcuts_search_action 
    input_id = products_id_form

    product_hashs = get_request("/products?search=#{input_id}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  def products_sort_action(attribute)

    product_hashs = get_request("/products?sort=#{attribute}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end 

  def orders_create_action

  end 

end 