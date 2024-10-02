# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clean the database
puts 'Cleaning the database...'
User.destroy_all

# Create a default user
puts 'Creating default user...'
User.create!(email: 'lucas@scuba.com', password:'Password1!')
