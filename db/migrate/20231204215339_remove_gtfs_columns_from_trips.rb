# frozen_string_literal: true

#  https://gtfs.org/schedule/reference/#tripstxt
class RemoveGtfsColumnsFromTrips < ActiveRecord::Migration[7.1]
  def change
    change_table :trips do |t|
      t.remove :gtfs_trip_id, :gtfs_route_id, :gtfs_service_id, :gtfs_shape_id
    end
  end
end
