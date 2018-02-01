module ProductsViews

  def products_show_view(product)

      puts 
      puts "ID Number: #{product.id} - #{product.name}"
      puts 
      puts product.description
      puts
      puts "Supplier: #{product.supplier_name}"
      puts 
      puts "Price: #{product.price} "
      puts "        +"
      puts "Tax:   #{product.tax} "
      puts "============================="
      puts "Total: #{product.total}"
      puts
      puts "Images: "
      product.image_url.each do |image_url|
        puts "     •#{product.image_url}"
      end 
      puts

  end  

  def products_index_view(products)

      products.each do |product|
        puts "============================"
        products_show_view(product)
      end 
  end 

  def products_id_form
    print "Enter product ID: "
    gets.chomp 
  end 

  def products_new_form
    client_params = {}
      
      print "Name: "
      client_params[:name] = gets.chomp

      print "In Stock?: "
      client_params[:in_stock?] = gets.chomp 
      
      print "Price: "
      client_params[:price] = gets.chomp 
      
      print "Description: "
      client_params[:description] = gets.chomp

      print "Supplier Id: "
      client_params[:supplier_id] = gets.chomp 
      
      client_params
  end 

  def products_update_form(product)
    client_params = {}
      
      print "Name (#{product.name}): "
      client_params[:name] = gets.chomp
      
      print "Price (#{product.price}): "
      client_params[:price] = gets.chomp 
      
      print "Description (#{product.description}): "
      client_params[:description] = gets.chomp

      print "Supplier Id: (#{product.supplier_id})"
      client_params[:supplier_id] = gets.chomp 
      
      client_params.delete_if{ |key, value| value.empty?}
      client_params
  end 

  def products_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end 

  def orders_new_form

    client_params = {}
      
      print "Product Id: "
      client_params[:product_id] = gets.chomp

      print "How many?: "
      client_params[:quantity] = gets.chomp 
      
      client_params
  end 

end 