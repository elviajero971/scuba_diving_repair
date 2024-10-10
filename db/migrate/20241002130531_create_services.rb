class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gear, null: false, foreign_key: true
      t.integer :type
      t.integer :status

      t.timestamps
    end
  end
end
