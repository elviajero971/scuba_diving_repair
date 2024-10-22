class AddLastServiceToUserGears < ActiveRecord::Migration[7.0]
  def change
    add_column :user_gears, :last_service, :datetime
  end
end
