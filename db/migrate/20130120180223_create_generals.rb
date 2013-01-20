class CreateGenerals < ActiveRecord::Migration
  def change
    create_table :generals do |t|
      t.text :description
      t.integer :trails_open
      t.integer :trails_total
      t.integer :tows_open
      t.integer :tows_total
      t.integer :tubing_lanes_open
      t.integer :vertical_drop
      t.boolean :new_snow_last_7
      t.string :snow_base

      t.timestamps
    end
  end
end
