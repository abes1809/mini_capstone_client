module ProductsController 

  def products_index_action
   product_hashs = get_request("/products")
   products = Product.convert_hashs(product_hashs)

   products_index_view(products)
  end 

  def products_show_action 
    input_id = products_id_form

    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    products_show_view(product)
  end

  def products_create_action
    client_params = products_new_form
    response = Unirest.post(
                              "http://localhost:3000/products",
                               parameters: client_params              
                              )

      if product_hash
        product_hash = response.body
        product = Products.new(product_hash)
        products_show_view(product)
      else 
        errors = response.body["errors"]
        products_errors_view(errors)
      end 
  end 

  def product_update_action

      input_id = products_id_form

      product_hash = get_request("/products/#{input_id}}") 
      product = Product.new(product_hash)

      client_params = products_update_form(product)

      response =  Unirest.patch(
                  "http://localhost:3000/products/#{input_id}",
                  parameters: client_params              
                              )

      if response.code == 200 
        products_hash = response.body
        product = Product.new(product_hash)
        products_show_view(product) 
      else 
        errors = response.body["errors"]
        products_errors_view(errors)
        end 
      end
  end

  def products_destroy_action

    print "Enter product ID: "
    input_id = gets.chomp 

    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    data = response.body 
    puts data["message"]
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

end 