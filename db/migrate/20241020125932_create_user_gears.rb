class CreateUserGears < ActiveRecord::Migration[7.0]
  def change
    create_table :user_gears do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gear, null: false, foreign_key: true

      t.timestamps
    end
  end
end
