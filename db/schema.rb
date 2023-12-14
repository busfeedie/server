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

ActiveRecord::Schema[7.1].define(version: 2023_12_14_213510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "agencies", force: :cascade do |t|
    t.string "gtfs_agency_id", null: false
    t.string "agency_name", null: false
    t.string "agency_url", null: false
    t.string "agency_timezone", null: false
    t.string "agency_lang"
    t.string "agency_phone"
    t.string "agency_fare_url"
    t.string "agency_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_agencies_on_app_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendar_dates", force: :cascade do |t|
    t.bigint "calendar_id"
    t.date "date", null: false
    t.integer "exception_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.string "gtfs_service_id", null: false
    t.index ["app_id"], name: "index_calendar_dates_on_app_id"
    t.index ["calendar_id"], name: "index_calendar_dates_on_calendar_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "gtfs_service_id", null: false
    t.boolean "monday", null: false
    t.boolean "tuesday", null: false
    t.boolean "wednesday", null: false
    t.boolean "thursday", null: false
    t.boolean "friday", null: false
    t.boolean "saturday", null: false
    t.boolean "sunday", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_calendars_on_app_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

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
    t.bigint "agency_id"
    t.bigint "app_id", null: false
    t.index ["agency_id"], name: "index_routes_on_agency_id"
    t.index ["app_id"], name: "index_routes_on_app_id"
  end

  create_table "shapes", force: :cascade do |t|
    t.string "gtfs_shape_id", null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.integer "shape_pt_sequence", null: false
    t.float "shape_dist_traveled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_shapes_on_app_id"
  end

  create_table "stop_times", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "stop_id", null: false
    t.time "arrival_time"
    t.time "departure_time"
    t.integer "stop_sequence", null: false
    t.string "stop_headsign"
    t.integer "pickup_type", default: 0, null: false
    t.integer "drop_off_type", default: 0, null: false
    t.integer "continuous_pickup", default: 1, null: false
    t.integer "continuous_drop_off", default: 1, null: false
    t.float "shape_dist_traveled"
    t.boolean "timepoint", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_stop_times_on_app_id"
    t.index ["stop_id"], name: "index_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_stop_times_on_trip_id"
  end

  create_table "stops", force: :cascade do |t|
    t.string "gtfs_stop_id", null: false
    t.string "stop_code"
    t.string "stop_name"
    t.string "tts_stop_name"
    t.string "stop_desc"
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "gtfs_zone_id"
    t.string "stop_url"
    t.integer "location_type", default: 0
    t.bigint "parent_station_id"
    t.string "stop_timezone"
    t.integer "wheelchair_boarding", default: 0
    t.string "gtfs_level_id"
    t.string "platform_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_stops_on_app_id"
    t.index ["parent_station_id"], name: "index_stops_on_parent_station_id"
  end

  create_table "trip_identifiers", force: :cascade do |t|
    t.date "start_date"
    t.time "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gtfs_trip_id"
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_trip_identifiers_on_app_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "trip_headsign"
    t.string "trip_short_name"
    t.integer "direction"
    t.string "block_id"
    t.integer "wheelchair_accessible"
    t.integer "bikes_allowed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "route_id"
    t.bigint "shape_id"
    t.bigint "app_id", null: false
    t.string "gtfs_trip_id", null: false
    t.string "service_id", null: false
    t.string "service_type", null: false
    t.index ["app_id"], name: "index_trips_on_app_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
    t.index ["shape_id"], name: "index_trips_on_shape_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_users_on_app_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
    t.bigint "app_id", null: false
    t.index ["app_id"], name: "index_vehicle_positions_on_app_id"
    t.index ["trip_id"], name: "index_vehicle_positions_on_trip_id"
    t.index ["trip_identifier_id"], name: "index_vehicle_positions_on_trip_identifier_id"
  end

  add_foreign_key "calendar_dates", "calendars"
  add_foreign_key "stop_times", "stops"
  add_foreign_key "stop_times", "trips"
  add_foreign_key "stops", "stops", column: "parent_station_id"
  add_foreign_key "trips", "shapes"
end
