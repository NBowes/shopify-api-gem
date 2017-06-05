require 'shopify_api'
require 'dotenv'
Dotenv.load

API_KEY = ENV['API_KEY']
PASSWORD = ENV['PASSWORD']
SHOP_NAME = 'bowes-guitars'
SHOP_URL = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = SHOP_URL

puts "Do you want to create a product?(yes/no)"
answer = gets.chomp

if answer == 'yes'
puts "We're going to make a product"
puts "What is the title?"
title = gets.chomp
puts "What type of product is it?"
product_type = gets.chomp
puts "How much does it cost? (only numbers please)"
price = gets.chomp

new_product = ShopifyAPI::Product.new(
  title: title,
  product_type: product_type,
  price: price,
  vendor: "MACBOOK"
)
puts "Creating new product"

new_product.save

puts "Product #{new_product.title} created"
else
  puts "No worries, there are other things we can do!"
end

def create_order(variant_id, quantity)
  order = ShopifyAPI::Order.new(
    line_items:[
      {
        variant_id: variant_id,
        quantity: quantity
      }
    ]
  )
  order.save
end

puts "Do you want to create an order too? (yes/no)"
answer = gets.chomp

if answer == 'yes'

puts "What is the variant id you are selling? (1263093383 / 1248799875 / 680647106)"
variant_id = gets.chomp
puts "How many do you want? (1/2/3)"
quantity = gets.chomp

create_order(variant_id, quantity)

puts "Order created!"
else
  puts "Ok, we're all done here."
  puts "Type 'ruby app.rb' to create more fun things!"
end
