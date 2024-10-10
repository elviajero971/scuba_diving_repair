class RenameTypeToServiceTypeForServices < ActiveRecord::Migration[7.0]
  def change
    rename_column :services, :type, :service_type
  end
end
