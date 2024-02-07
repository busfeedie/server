class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :label
      t.string :license_plate
      t.integer :wheelchair_accessible
      t.references :app, null: false
      t.timestamps
    end
  end
end
