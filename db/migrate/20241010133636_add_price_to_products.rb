class AddPriceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price, :integer, null: false, default: 0
  end
end
