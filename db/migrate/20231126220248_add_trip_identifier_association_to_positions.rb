# frozen_string_literal: true

# Adds the association with the trip identifier table to the vehicle positions table
class AddTripIdentifierAssociationToPositions < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicle_positions, :trip_identifier
  end
end
