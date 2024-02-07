class AddVehicleToVehiclePosition < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicle_positions, :vehicle
  end
end
