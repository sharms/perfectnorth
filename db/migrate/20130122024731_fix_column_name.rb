class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :slopes, :status, :is_open
    rename_column :tubing_carpets, :status, :is_open
  end
end
