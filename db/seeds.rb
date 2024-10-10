# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clean the database
puts 'Cleaning the database...'
Payment.destroy_all
Service.destroy_all
User.destroy_all
Gear.destroy_all
Brand.destroy_all
Product.destroy_all

# Create a default user
puts 'Creating default user...'
User.create!(email: 'lucas@scuba.com', password:'Password1!')

# Create brands
puts 'Creating brands...'
brands = Brand.create!([
  { name: 'Aqualung' },
  { name: 'Scubapro' },
  { name: 'Mares' },
  { name: 'Cressi' }
])

# Create gears
puts 'Creating gears...'
gears = Gear.create!([
  { name: 'Legend LX Supreme', brand: brands[0], gear_type: :regulator },
  { name: 'MK25 EVO/S600', brand: brands[1], gear_type: :regulator },
  { name: 'Loop 15X', brand: brands[2], gear_type: :regulator },
  { name: 'T10-SC Cromo Master', brand: brands[3], gear_type: :regulator }
])

puts 'create products...'
Product.create!(name: 'repair_basic', product_type: :basic, description: 'Basic way to repair', stripe_price_id: 'price_1Q7e7PHwg4T1nYcECYPWp5UM', price: 80)
Product.create!(name: 'repair_premium', product_type: :premium, description: 'Faster way to repair', stripe_price_id: 'price_1Q7e80Hwg4T1nYcEHPNiT9Fh', price: 120)


