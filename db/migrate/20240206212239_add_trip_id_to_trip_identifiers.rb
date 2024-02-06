class AddTripIdToTripIdentifiers < ActiveRecord::Migration[7.1]
  def change
    add_reference :trip_identifiers, :trip
  end
end
