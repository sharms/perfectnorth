class CreateSlopes < ActiveRecord::Migration
  def change
    create_table :slopes do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
