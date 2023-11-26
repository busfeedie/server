class AddVehiclePositions < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicle_positions do |t|
      t.st_point :lonlat, geographic: true, null: false
      t.float :bearing, null: true
      t.float :odometer, null: true
      t.float :speed, null: true
      t.integer :vehicle_stop_status, null: true
      t.datetime :measured_at, null: true
      t.integer :congestion_level, null: true
      t.integer :occupancy_percentage, null: true
    end
  end
end
