class AddAmountToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :amount, :integer, null: false
  end
end
