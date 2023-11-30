# frozen_string_literal: true

# https://gtfs.org/schedule/reference/#stopstxt
class CreateStops < ActiveRecord::Migration[7.1]
  def change
    create_table :stops do |t|
      t.string :gtfs_stop_id, null: false
      t.string :stop_code
      t.string :stop_name
      t.string :tts_stop_name
      t.string :stop_desc
      t.st_point :lonlat, geographic: true
      t.string :zone_id
      t.string :stop_url
      t.integer :location_type
      t.references :parent_station, foreign_key: { to_table: :stops }
      t.string :stop_timezone
      t.integer :wheelchair_boarding
      t.string :gtfs_level_id
      t.string :platform_code
      t.timestamps
    end
  end
end
