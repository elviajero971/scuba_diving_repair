class AddProductTypeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_type, :integer, default: 0
  end
end
