class CreateTubingCarpets < ActiveRecord::Migration
  def change
    create_table :tubing_carpets do |t|
      t.integer :number
      t.boolean :status

      t.timestamps
    end
  end
end
