# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.
# rubocop:disable all
ActiveRecord::Schema[7.1].define(version: 2023_11_28_212238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "routes", force: :cascade do |t|
    t.string "gtfs_route_id", null: false
    t.string "gtfs_agency_id", null: false
    t.string "route_short_name"
    t.string "route_long_name"
    t.string "route_desc"
    t.integer "route_type", null: false
    t.string "route_url"
    t.string "route_color"
    t.string "route_text_color"
    t.integer "route_sort_order"
    t.integer "continuous_pickup", default: 1
    t.integer "continuous_drop_off", default: 1
    t.string "gtfs_network_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trip_identifiers", force: :cascade do |t|
    t.date "start_date"
    t.time "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gtfs_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "gtfs_trip_id", null: false
    t.string "gtfs_route_id", null: false
    t.string "gtfs_service_id", null: false
    t.string "trip_headsign"
    t.string "trip_short_name"
    t.integer "direction"
    t.string "block_id"
    t.string "gtfs_shape_id"
    t.integer "wheelchair_accessible"
    t.integer "bikes_allowed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "route_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  create_table "vehicle_positions", force: :cascade do |t|
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.float "bearing"
    t.float "odometer"
    t.float "speed"
    t.integer "vehicle_stop_status"
    t.datetime "measured_at"
    t.integer "congestion_level"
    t.integer "occupancy_percentage"
    t.bigint "trip_identifier_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_vehicle_positions_on_trip_id"
    t.index ["trip_identifier_id"], name: "index_vehicle_positions_on_trip_identifier_id"
  end

end
