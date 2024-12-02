class Product < ApplicationRecord
  enum :product_type, { :basic => 0, :premium => 1 }
  validates :name, :description, :stripe_price_id, presence: true
end
