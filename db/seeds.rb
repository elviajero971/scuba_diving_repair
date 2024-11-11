# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clean the database
puts 'Cleaning the database...'
Payment.destroy_all
Service.destroy_all
UserGear.destroy_all
User.destroy_all
Gear.destroy_all
Brand.destroy_all
Product.destroy_all

# Create a default user
puts 'Creating admin user...'
User.create!(email: 'admin@scuba.com', password:'Password1!', role: :admin)

puts 'Creating users...'
User.create!(email: 'bob@scuba.com', password:'Password1!', role: :client)
User.create!(email: 'jean@scuba.com', password:'Password1!', role: :client)
User.create!(email: 'elodie@scuba.com', password:'Password1!', role: :client)

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
puts 'Creating gears regulators...'
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

# Create gears
puts 'Creating gears bcds...'

gears = Gear.create!(
  [
    # Aqua Lung BCDs
    { name: 'Pro HD', brand: brands[0], gear_type: :bcd },
    { name: 'Outlaw', brand: brands[0], gear_type: :bcd },
    { name: 'Pearl', brand: brands[0], gear_type: :bcd },
    { name: 'Zuma', brand: brands[0], gear_type: :bcd },
    { name: 'Rogue', brand: brands[0], gear_type: :bcd },

    # Scubapro BCDs
    { name: 'Hydros Pro', brand: brands[1], gear_type: :bcd },

    # Mares BCDs
    { name: 'Hybrid Pure', brand: brands[2], gear_type: :bcd },
    { name: 'Prime', brand: brands[2], gear_type: :bcd },
    { name: 'Kaila SLS', brand: brands[2], gear_type: :bcd },
    { name: 'Dragon SLS', brand: brands[2], gear_type: :bcd },
    { name: 'Bolt SLS', brand: brands[2], gear_type: :bcd },

    # Cressi BCDs
    { name: 'Start Pro 2.0', brand: brands[3], gear_type: :bcd },
    { name: 'Travelight', brand: brands[3], gear_type: :bcd },
    { name: 'Aquaride Pro', brand: brands[3], gear_type: :bcd },
    { name: 'Donut Wing', brand: brands[3], gear_type: :bcd },
    { name: 'Back Jac', brand: brands[3], gear_type: :bcd },

    # Apeks BCDs
    { name: 'Black Ice', brand: brands[4], gear_type: :bcd },
    { name: 'WTX-D18', brand: brands[4], gear_type: :bcd },
    { name: 'WTX-D45', brand: brands[4], gear_type: :bcd },
    { name: 'WTX-D60', brand: brands[4], gear_type: :bcd },
    { name: 'WTX-D30', brand: brands[4], gear_type: :bcd }
  ]
)

puts 'create products...'
Product.create!(name: 'repair_basic', product_type: :basic, description: 'Basic way to repair', stripe_price_id: 'price_1Q7e7PHwg4T1nYcECYPWp5UM', price: 80)
Product.create!(name: 'repair_premium', product_type: :premium, description: 'Faster way to repair', stripe_price_id: 'price_1Q7e80Hwg4T1nYcEHPNiT9Fh', price: 120)


