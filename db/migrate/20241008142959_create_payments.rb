class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :service, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :stripe_payment_id

      t.timestamps
    end
  end
end
