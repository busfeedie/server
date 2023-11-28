# frozen_string_literal: true

# Adds the routes table to the database
class CreateRoutesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      t.string :gtfs_route_id, null: false
      t.string :gtfs_agency_id, null: false
      t.string :route_short_name
      t.string :route_long_name
      t.string :route_desc
      t.integer :route_type, null: false
      t.string :route_url
      t.string :route_color
      t.string :route_text_color
      t.integer :route_sort_order
      t.integer :continuous_pickup, default: 1
      t.integer :continuous_drop_off, default: 1
      t.string :gtfs_network_id
      t.timestamps
    end
  end
end
