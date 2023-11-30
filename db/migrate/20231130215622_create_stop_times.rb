# frozen_string_literal: true

# https://gtfs.org/schedule/reference/#stop_timestxt
class CreateStopTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :stop_times do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :stop, null: false, foreign_key: true
      t.time :arrival_time
      t.time :departure_time
      t.integer :stop_sequence, null: false
      t.string :stop_headsign
      t.integer :pickup_type, null: false, default: 0
      t.integer :drop_off_type, null: false, default: 0
      t.integer :continuous_pickup, null: false, default: 1
      t.integer :continuous_drop_off, null: false, default: 1
      t.float :shape_dist_traveled
      t.boolean :timepoint, null: false, default: true
      t.timestamps
    end
  end
end
