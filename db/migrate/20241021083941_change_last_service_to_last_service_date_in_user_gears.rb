class ChangeLastServiceToLastServiceDateInUserGears < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_gears, :last_service, :last_service_date

    change_column :user_gears, :last_service_date, :date
  end
end
