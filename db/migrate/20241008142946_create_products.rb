class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :stripe_price_id, null: false

      t.timestamps
    end
  end
end
