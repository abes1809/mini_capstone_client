class Product

  attr_accessor :id, :name, :image_url, :description, :is_discounted, :tax, :total, :price, :formatted_price, :supplier_name, :supplier_id, :image_url
  
  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @description = input_options["description"]
    @is_discounted = input_options["is_discounted"]

    @tax = input_options["tax"]
    @total = input_options["total"]
    @price = input_options["price"]

    @formatted_price = input_options["formatted"]["price"]

    @supplier_name = input_options["supplier"]["name"]
    @supper_id = input_options["supplier"]["id"]

    @image_url = input_options["image"]
  end

  def self.convert_hashes(product_hashs)
    collection = []

    product_hashs.each do |product_hash|
      collection << Product.new(product_hash)
   end

    collection 
  end 
end 