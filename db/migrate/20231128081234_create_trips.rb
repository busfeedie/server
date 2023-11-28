# Adds the trips table https://gtfs.org/schedule/reference/#tripstxt
class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :gtfs_trip_id, null: false
      t.string :gtfs_route_id, null: false
      t.string :gtfs_service_id, null: false
      t.string :trip_headsign
      t.string :trip_short_name
      t.integer :direction
      t.string :block_id
      t.string :gtfs_shape_id
      t.integer :wheelchair_accessible
      t.integer :bikes_allowed
      t.timestamps
    end
  end
end
