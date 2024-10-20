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
brands = Brand.create!(
  [
   { name: 'Aqualung' },
   { name: 'Scubapro' },
   { name: 'Mares' },
   { name: 'Cressi' },
   { name: 'Apeks' }
 ]
)

# Create gears
puts 'Creating gears...'
gears = Gear.create!(
  [
   # Aqua Lung Regulators
   { name: 'Legend LX Supreme', brand: brands[0], gear_type: :regulator },
   { name: 'Core Supreme', brand: brands[0], gear_type: :regulator },
   { name: 'Mikron', brand: brands[0], gear_type: :regulator },
   { name: 'Titan', brand: brands[0], gear_type: :regulator },
   { name: 'Helix Pro', brand: brands[0], gear_type: :regulator },

   # Scubapro Regulators
   { name: 'MK25 EVO/A700', brand: brands[1], gear_type: :regulator },
   { name: 'MK17 EVO/G260', brand: brands[1], gear_type: :regulator },
   { name: 'MK11/C370', brand: brands[1], gear_type: :regulator },
   { name: 'MK2 EVO/R195', brand: brands[1], gear_type: :regulator },
   { name: 'MK25 EVO/S600', brand: brands[1], gear_type: :regulator },

   # Mares Regulators
   { name: 'Abyss 22', brand: brands[2], gear_type: :regulator },
   { name: 'Rover 2S', brand: brands[2], gear_type: :regulator },
   { name: 'Epic ADJ 82X', brand: brands[2], gear_type: :regulator },
   { name: 'Prestige 15X', brand: brands[2], gear_type: :regulator },
   { name: 'Fusion 52X', brand: brands[2], gear_type: :regulator },

   # Cressi Regulators
   { name: 'AC2 Compact', brand: brands[3], gear_type: :regulator },
   { name: 'MC9-SC Compact Pro', brand: brands[3], gear_type: :regulator },
   { name: 'T10-SC Master', brand: brands[3], gear_type: :regulator },
   { name: 'XS Compact AC2', brand: brands[3], gear_type: :regulator },
   { name: 'T10-SC Carbon', brand: brands[3], gear_type: :regulator },

   # Apeks Regulators
   { name: 'XTX200', brand: brands[4], gear_type: :regulator },
   { name: 'XTX50', brand: brands[4], gear_type: :regulator },
   { name: 'MTX-R', brand: brands[4], gear_type: :regulator },
   { name: 'XTX40', brand: brands[4], gear_type: :regulator },
   { name: 'ATX40', brand: brands[4], gear_type: :regulator }
  ]
)

puts 'create products...'
Product.create!(name: 'repair_basic', product_type: :basic, description: 'Basic way to repair', stripe_price_id: 'price_1Q7e7PHwg4T1nYcECYPWp5UM', price: 80)
Product.create!(name: 'repair_premium', product_type: :premium, description: 'Faster way to repair', stripe_price_id: 'price_1Q7e80Hwg4T1nYcEHPNiT9Fh', price: 120)


