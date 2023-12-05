# frozen_string_literal: true

# adds the gtfs_trip_id column to the trips table
class Add < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :gtfs_trip_id, :string, null: false
  end
end
