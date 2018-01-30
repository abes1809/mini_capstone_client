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
      
      print "Image_url: "
      client_params[:image_url] = gets.chomp
      
      print "Description: "
      client_params[:description] = gets.chomp
      
      client_params
  end 

  def products_update_form(product)
    client_params = {}
      
      print "Name (#{product.name}): "
      client_params[:name] = gets.chomp

      print "In Stock? (#{product.in_stock?}): "
      client_params[:in_stock?] = gets.chomp 
      
      print "Price (#{product.price}): "
      client_params[:price] = gets.chomp 
      
      print "Image_url (#{product.image_url}): "
      client_params[:image_url] = gets.chomp
      
      print "Description (#{product.description}): "
      client_params[:description] = gets.chomp
      
      client_params.delete_if{ |key, value| value.empty?}
      client_params
  end 

  def products_errors_view(errors)
    errors.each do |error|
      puts error
    end
  end 



end 