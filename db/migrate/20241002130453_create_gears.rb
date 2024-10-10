class CreateGears < ActiveRecord::Migration[7.0]
  def change
    create_table :gears do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
