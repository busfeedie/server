class AddTripIdToVehiclePosition < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicle_positions, :trip
    add_column :trip_identifiers, :gtfs_trip_id, :bigint
  end
end
