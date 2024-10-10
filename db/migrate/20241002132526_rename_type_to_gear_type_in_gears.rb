class RenameTypeToGearTypeInGears < ActiveRecord::Migration[7.0]
  def change
    rename_column :gears, :type, :gear_type
  end
end
