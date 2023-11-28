class AddRouteAssociationToTrip < ActiveRecord::Migration[7.1]
  def change
    add_reference :trips, :route
  end
end
