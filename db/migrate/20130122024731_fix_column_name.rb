class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :slopes, :status, :trail_open
    rename_column :tubing_carpets, :status, :trail_open
  end
end
