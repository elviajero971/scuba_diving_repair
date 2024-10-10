class AddPaymentStatusToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :payment_status, :integer, default: 0
  end
end
